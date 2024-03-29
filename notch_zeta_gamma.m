%% Compare the effect of zeta & gamma on notch filters
close all;

fc = 16;   % Hz

opt = bodeoptions('cstprefs');
opt.FreqUnits = 'Hz';
opt.Grid = 'on';
opt.XLim = [5 50];


%% The effect of zeta
h=figure(1); set(h,'name','Effect of zeta');
gamma = 0.5;
zeta_arr = [0,0.05,0.1];
for zeta = zeta_arr   
    n = design_notch(fc, gamma, zeta);
    bode(n, opt); hold on; 
end
hold off; widen(h);
legend(...
    arrayfun(@(z) sprintf('$\\zeta=%.2f$', z), zeta_arr, 'UniformOutput', false), ...
    'interpreter', 'latex', ...
    'fontsize', 14 ...
);


%% The effect of gamma
zeta = 0.1;
gamma_arr = [1.0,0.5,0.25];

h=figure(2); set(h,'name','Effect of gamma');
for gamma = gamma_arr   
    n = design_notch(fc, gamma, zeta);
    bode(n, opt); hold on; 
end
hold off; widen(h);
legend(...
    arrayfun(@(z) sprintf('$\\gamma=%.2f$', z), gamma_arr, 'UniformOutput', false), ...
    'interpreter', 'latex', ...
    'fontsize', 14 ...
);