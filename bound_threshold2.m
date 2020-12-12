function [p] = bound_threshold2(x)

global q

n = 10;
k = 1;
d = 3;


mu = (n-1)*x;

delta = k/((n-1)*x)-1;

%p = exp(-delta^2*mu/(2+mu))-10^(-d);
 
p = (exp(delta)/((1+delta)^(1+delta)))^mu;

%q = exp(-n*(a*log(a./x)+(1-a)*log((1-a)./(1-x))));
 