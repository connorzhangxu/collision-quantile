function [q] = bound_threshold(x)

global n k d
%n = 10;
%k = 1;
%d = 3;


q = binocdf(k,n-1,x,'upper')-(0.1)^d;
 