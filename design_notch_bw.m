function notch_filt = design_notch_bw(fm, gamma, bw, varargin)
%design_notch_bw   design a 2nd order notch filter in continous time for a
%certain bandwidth
%   fm:     notch freq in Hz
%   gamma:  notch depth in absolute units (min gain)
%   bw:     notch bandwidth (width of region where gain < bwg)
%   bwg:    bandwidth gain (default -3db)
%Run without output args to plot the notch

    bwg = db2mag(-3);
    if nargin == 4
        bwg = varargin{1};
    end
    
    tgt_f = (fm - bw/2) * 2*pi;  % rad/s
        
    zeta = optimize( ...
        @(z) cost(design_notch(fm,gamma,z), tgt_f, bwg), ...
        2.5,    ...
        [0,5]   ...
    );
    
    notch_filt = design_notch(fm, gamma, zeta);
        
    if nargout == 0
        fprintf('Optimal zeta: %.3f\n', zeta);
        
        opt = bodeoptions('cstprefs');
        opt.FreqUnits = 'Hz';
        opt.Title.String = 'Notch Filter';
        opt.Grid = 'on';
        bode(notch_filt, opt);
    end
end

function x = optimize(fun, x0, bounds)
    opt = optimset('fmincon');
    opt.Display = 'off';
    x = fmincon(fun, x0, [], [], [], [], bounds(1), bounds(2), [], opt);
end

function J = cost(n, ft, bwg)
    mag = abs(bode(n, ft));
    J = (mag-bwg)^2;
end
