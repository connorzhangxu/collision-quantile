clear all
clc

OPTIONS = optimset('tolx',1e-10,'tolf',1e-12);

global n tau y

n=1000;

load graph.mat

A = A - eye(n);

d = sum(A);

C = zeros(n,n);

for i = 1:n
    
    for l = find(A(i,:))
        
        if i ~= l 
            
            C(l,i) = (max(d(i),d(l)))^-1;
        
        end
            
    end
    
end

for i = 1:n

    C(i,i) = 1 - sum(C(:,i));
    
end
    
C;
            
max(abs(eig(C - ones(n)/n)))


%%%%%%%%%%%%%%

sample_paths = [];

for sample = 1:1

n=1000;

k = 0.1*n;

tau = 0.5*((n-k) + (n-k+1))/n;

x = randn(n,1);

%x = laprnd(n,1,0,1);

y = round(abs(x),10);

w = round(fminsearch('quantile_cost_global',0,OPTIONS),10);

y = sort(y,'descend');

w-y(k)

end

% 
% pause
% 
% u = (y-w > 0);
% 
% sum(u)
% 
% if sum(u)>k
%     
%     JQ = mean(y.^2);
%     
% else 
%     
%     JQ = mean(y.^2.*(1-u));
%     
% end
% 
% sample_paths = [sample_paths; JQ];
% 
% end
% 
% mean(sample_paths)

