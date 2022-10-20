% ROBUST DESIGN Toolbox  Version: 2.4 (MATLAB 5)  Date : April 29, 1997
% ============================================================================
% The functions in this toolbox can be used to predict and optimize designs
% using Monte Carlo simulation and Statistical sensitivity analysis.
% ----------------------------------------------------------------------------
% General functions:
% RND_VECT: Generate a random vector for use in Monte Carlo analysis
% HIST_TXT: Plot a relative frequency histogram with title, xlabel and ylabel
% HIST_REP: Plot a histogram with statistical information and comment lines
% YIELD   : Calculate the yield for one or multiple output variable
% PERFORM : Calculate capability indicators Cp and Cpk for an output variable
% PASSFAIL: Calculate statistical sensitivity of input x to output y
% CORRELAT: Calculate correlation coefficient of input x to output y.
% PFPARETO: Calculate and plot a Pareto diagram of statistical sensitivities
% PFPARETM: Calculate and plot a Pareto diagram (matrix version)
% CPARETO : Plot a Pareto diagram of correlation coefficients.
% CPARETM : Plot a Pareto diagram of correlation coefficients (matrix version).
% RPARETO : Plot a Pareto diagram of regression coefficients.
% RPARETM : Plot a Pareto diagram of regression coefficients (matrix version).
% ----------------------------------------------------------------------------
% Specific functions:
% PDFUN   : Calculate or plot a probability density function
% CUM_PDF : Calculate or plot a cumulative probability function
% STRSUS  : Calculate reliability normal distrib. stressor & susceptibility
% WHERE   : Perform if .. then v=a else v=b construction on vector or matrix
% ----------------------------------------------------------------------------
% Functions intended for internal usage:
% HIST_2  : Plot a combined histogram for two parameters
% MESSAGE : Display a warning message
% PFSPLIT : Split vector or matrix in passes and fails
% TIME_STR: Return the actual date and time in a string
% ----------------------------------------------------------------------------
% Example:
% RD_EXAMP: Example using simple bar formulas
% ============================================================================

