function notch_filt = design_notch(fm, gamma, zeta)
%design_notch   design a 2nd order notch filter in continous time
%   fm:     notch freq in Hz
%   gamma:  notch depth in absolute units (min gain)
%   zeta:   notch damping (width of notch)
%Run without output args to plot the notch

    fmr = fm * 2 * pi;
    
    n = [1 2*zeta*fmr*gamma fmr*fmr];
    d = [1 2*zeta*fmr fmr*fmr];
    
    notch_filt = tf(n, d);
    
    if nargout == 0
        opt = bodeoptions('cstprefs');
        opt.FreqUnits = 'Hz';
        opt.Title.String = 'Notch Filter';
        opt.Grid = 'on';
        bode(notch_filt, opt);
    end
end

