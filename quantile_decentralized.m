clear all
clc


%W = GenerateRandomSymetricMatrix(1000,0.025);

OPTIONS = optimset('tolx',1e-10,'tolf',1e-10);

global n tau y var


load graph1.mat

n = 1000;

A = A - eye(n);

%n=1000;

n_iter = 10;

d = sum(A);

d_max = max(d);

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
    
%C;
            
%max(abs(eig(C - ones(n)/n)));

%%%%%%%%%%%%%%

%sample_paths = [];

%for sample = 1
    
    %sample
    
    %J_history = [];

    k = 0.1*n;

    tau = 0.5*((n-k) + (n-k+1))/n;

    rng(1)

    x = randn(n,1);

    y = round(abs(x),10);

    s = sort(y,'descend');

    s(k)

    w = round(fminsearch('quantile_cost_global',0,OPTIONS),10)
    
    pause

    w = y;

%for i = 1:n
    
%var = y(i);
    
%w(i) = probit(tau);

%end

% w_history = [];
% 

t=0;

 while std(w)>10^-3
     
    t=t+1;

    s = zeros(n,1);
 
    for i = 1:n
    
        s(i) = sub_grad_pinball(y(i),w(i));
     
    end
 
    phi = w - eta(t)*s;
 
    phi_new = zeros(n,1);
        
        for i=1:n
            
            N_i = find(A(i,:)==1);
            
            d_i = length(N_i);
            
            phi_new(i) = phi(i)*(1-d_i/d_max) + sum(phi(N_i))/d_max;
            
        end
        
        
        w = phi_new;
 
    w(1)

 
 end
 
% %u = (y-w >= 0);
% 
% %sum(u);
% 
% %if sum(u)>k
%     
% %    JQ = mean(y.^2);
%     
% %else 
%     
% %    JQ = mean(y.^2.*(1-u));
%     
% %end
% 
% w_history = [w_history w];
% 
% end
% 
% 
% sample_paths = [sample_paths w_history];
% 
% 
% end
% 
% plot(sample_paths')

%mean(sample_paths)

 
%save('results_quantile2.mat','sample_paths')