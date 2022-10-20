% Changes in the Robust Design toolbox version 2.3
% ================================================
%
% New functions:
%
% correlat.m  Calculate correlation coefficient of input x to output y.
% cparetm.m   Plot Pareto diagram of correlation coefficients (matrix version).
% cpareto.m   Plot Pareto diagram of correlation coefficients.
% pfsplit.m   Select passes and fails in output
% rd_examp.m  Bar calculation example instead of old rd_exam
%
% ------------------------------------------------
% Changes in other functions:
%
% pdf.m
% - bug fixed.
%
% passfail.m
% - global variables are used to give an indication in function pfpareto.m and
%   function pfparetm.m of the situations where 'no passes', 'no fails' or
%   'no limits' exist.
% - the algorithm for the number of bins used for calculating the probability
%   density function for the passes and fails has changed
% - in plotoption 3 the scatterplots and the passfail diagram have the same
%   axis values now.
% - bug fixed for displaying title plot option 3 and 4
%
% perform.m
% - bug fixed in algorithm for single sided acceptance regions
%
% pfpareto.m and pfparetm.m
% - usage of variable opt for options extended.
% - global variables are used to give an indication the situations where
%   'no passes', 'no fails' or 'no limits' exist.
%
% rnd_vect.m
% - return value for number of samples is 1 and lognormal distribution is now
%   the median value for this distribution
% ================================================

