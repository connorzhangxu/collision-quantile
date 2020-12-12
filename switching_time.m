clear all
clc

load graph_100.mat

load('threshold_gaussian_new')

sigma = 0:0.0001:10;

d = sum(A);

G = zeros(size(A));

for i = 1:length(A)
    
    N_i = setdiff(find(A(i,:)==1),i);
    
    for j = 1:length(A)
        
       if i==j
           
           G(i,j) = 1;
           
           for l = N_i
              
               G(i,j) = G(i,j) - (max(d(i),d(l)))^-1;
               
           end
           
       end
       
       if i~=j && any(j==N_i)
          
           G(i,j) = (max(d(i),d(j)))^-1;
           
       end
        
    end
    
end

n = length(G);

d_max = max(d);

R = 0;

%x = randn(n,1);

%y = norm(x.^2 - mean(x.^2),1)

%histogram(y)

R_vector = []

for T = 1:1000
    
    R = 0;

x = randn(n,1);

y = x.^2;

mu = round(mean(x.^2),4);

DT = (T_star(round(mu/0.0001,4)+1)-T_star(round(mu/0.0001,4)))/(sigma(round(mu/0.0001,4)+1)-sigma(round(mu/0.0001,4)));

eta = 10^-2;

t = 0;

A = G^t;

while R == 0

    if norm((A - ones(n,n)/n)*y,inf) <= eta/DT
        
        R = t;
        break
        
    else
        
        t=t+1;
        
    end
    
    A = A*G;
    
end
R
R_vector = [R_vector; R];
%mean(R_vector)
end

mean(R_vector)
1.96*std(R_vector)/sqrt(1000)

%plot(sigma,[DT DT(length(DT)))

%DT = zeros(1,length(sigma)-1);

%for t=0:length(sigma)-2
    
    %t

%DT(t+1) = (T_star(t+2)-T_star(t+1))/(sigma(t+2)-sigma(t+1));

%end



