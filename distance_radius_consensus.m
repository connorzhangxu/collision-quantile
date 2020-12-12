clear all

clc


n=100;

x = randn(n,100000);

y = max(x.^2 - mean(x.^2));

%histogram(y)

mean(y)

load 'graph_100.mat'

d = sum(A);

G = zeros(size(A));

for i = 1:length(A)
    
    N_i = setdiff(find(A(i,:)==1),i);
    
    for j = 1:length(A)
        
       if i==j
           
           G(i,j) = 1;
           
           for l = N_i
              
               G(i,j) = G(i,j) - (1+max(d(i),d(l)))^-1;
               
           end
           
       end
       
       if i~=j && any(j==N_i)
          
           G(i,j) = (1+max(d(i),d(j)))^-1;
           
       end
        
    end
    
end

t = 100

norm(G^t-ones(n,n)/n,1)