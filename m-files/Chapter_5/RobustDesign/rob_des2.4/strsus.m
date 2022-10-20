function R=strsus(mu_stress,sigma_stress,mu_sus,sigma_sus)

% STRSUS: Calculate reliability normal distributed stressor & susceptibility
% ============================================================================
% R=strsus(mu_str,sigma_str,mu_sus,sigma_sus);
% ----------------------------------------------------------------------------
% R         : calculated reliability
% mu_str    : Mean value for the stressor
% sigma_str : Standard deviation for the stressor
% mu_sus    : Mean value for the susceptibility
% sigma_sus : Standard deviation for the susceptibility
% ----------------------------------------------------------------------------
% Example: R=strsus(mu_str,sigma_str,mu_sus,sigma_sus);
% ----------------------------------------------------------------------------
% Copyright: Reliability of Mech. Equipment - Eindhoven University Technology
%            Based on software originally developed by:
%             Quality Engineering - Philips Consumer Electronics
%             Reliability of Mech. Equipment - Eindhoven University Technology
%             Mech. Reliability - Philips Centre for Manufacturing Technology
% Version  : 2.3 (MATLAB 4)     Date : January 11, 1996
% ============================================================================

if sigma_stress==0 & sigma_sus==0,
  error('Sigma_stress and sigma_sus both 0')
end

% See K.C. Kapur & L.R. Lamberson, Reliability in Engineering design,
%     Ch. 6. John Wiley '77

% calculate z value
z = -(mu_stress - mu_sus) / sqrt(sigma_stress.^2 + sigma_sus.^2);

R = 0.5 * (erf(z/sqrt(2)) + 1);

% ============================================================================

