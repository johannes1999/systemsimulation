% RD_EXAMP: Robust Design toolbox example, Simple bar calculation
% ============================================================================
% Copyright: Reliability of Mech. Equipment - Eindhoven University Technology
%            Based on software originally developed by:
%             Quality Engineering - Philips Consumer Electronics
%             Reliability of Mech. Equipment - Eindhoven University Technology
%             Mech. Reliability - Philips Centre for Manufacturing Technology
% Version  : 2.3 (MATLAB 4)     Date : January 11, 1996
% ============================================================================

ttxt = 'Simulation results bar';	             % Definition title for plots
n = 1000;                                      % Number of simulations

% input variables
l = rnd_vect(n, 'normal', [10, 0.2/3]);        % Length [mm]
h = rnd_vect(n, 'normal', [1, 0.1/3]);         % Heigth [mm]
w = rnd_vect(n, 'normal', [3, 0.1/3]);         % Width [mm]
E = rnd_vect(n, 'normal', [3500, 350/3]);      % Elasticity [N/mm2]
F = rnd_vect(n, 'normal', [2.5, 0.25/3]);      % Force [N]

% maximum values
f_max = 1.2;                                   % max. deflection [mm]
s_max = 55;                                    % max. stress [N/mm2]

% output variables
I = w.*h.^3./12;                               % Moment of inertia [mm4]
f = F.*l.^3./(3.*E.*I);                        % Deflection [mm]
s = F.*l.*h./(2.*I);                           % Stress [N/mm2]

% plot results
figure(1)                                      % open figure window
hist_txt(f, 20, 'Deflection [mm]', ttxt);      % histogram deflection
figure(2)
hist_txt(s, 20, 'Stress [N/mm2]', ttxt);       % histogram stress

figure(4)
passfail(h, s, NaN, s_max, 4,...               % pass fail plot
         'Height', 'Stress', ttxt);

figure(5)
pfpareto(s, 'Stress', NaN, s_max,...           % stat. sens. pareto diagram
         ttxt, 1 , [], h, 'height' , l, 'length', w, 'width',...
         E,'Elasticity', F, 'Force');

[yld, cl] = yield(s, NaN , s_max);             % calculate yield stress
fprintf('\nYield: %4.2f +/- %4.2f\n',...       % display yield
        yld,cl);


