function vv=rnd_mat(ns,type,param1,param2,llim)

% RND_MAT: Generate a random matrix for use in Monte Carlo analysis
% see rnd_vect

% ============================================================================
% vv=rnd_vect(ns,type,param,[lsl],[usl])
% ----------------------------------------------------------------------------
% vv    : Variable (vector)
% ns    : Number of simulations. For ns==1 the mean value respectively the
%         location parameter or the median value is returned.
% type  : Type of distribution (text)
% param1
% param2: see rnd_vct
% lsl   : Lower limit for a truncated distribution
%         (scalar/vector, default=no limit). No lower limit: use NaN or []
%         The old syntax is still supported (lsl is a vector of two scalars
%         and usl is not specified)
% usl   : Upper limit for a truncated distribution
%         (scalar/vector, default=no limit). No upper limit: use NaN or []
%
% see rnd_vct
% ============================================================================
s=length(param1);

    for i=1:s
        vv(i,:)=rnd_vect(ns,type,[param1(i) param2(i)],llim);
    end
  