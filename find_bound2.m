
global q k n d var

k = 10;
n = 100;
for var = 1:5
d = 3;

%h = @(p) k*log(p) - (n-1)*p - k*log(k) + k + k*log(n-1) + d*log(10);

ezplot('bound3',[0,k/(n-1)]);

%ylim([-1,10])

%pause

 q = fzero('bound3',[eps,k/(n-1)]);
 
% 
%h = @(p) (k-(n-1)*(p))^2 - (k-(n-1)*(p))*d*log(10);
% 
% ezplot(h,[eps,k/(n-1)])
% 
% 
% q = fzero(h,[0,k/(n-1)])
% 
% %q =  1-(k-sqrt(2*k*d*log(10)))/(n-1)
% 
T= fzero('qinv',k/(n-1));
% 
round(T,2)
end