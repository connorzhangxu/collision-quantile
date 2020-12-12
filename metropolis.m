clear all 
clc

load graph1.mat

rng(1)

d = sum(A);

G = zeros(size(A));

for i = 1:length(A)
    
    N_i = setdiff(find(A(i,:)==1),i);
    
    for j = 1:length(A)
        
       if i==j
           
           G(i,j) = 1;
           
           for l = N_i
              
               G(i,j) = G(i,j) - (2*max(d(i),d(l)))^-1;
               
           end
           
       end
       
       if i~=j && any(j==N_i)
          
           G(i,j) = (2*max(d(i),d(j)))^-1;
           
       end
        
    end
    
end

G;

z = randn(length(G),1);

x = z.^2;

mean(x)

hist = [x];

T = 0;

while std(x) > 10^-6 
    
   T = T+1;
    
   x =  G*x;
    
   hist = [hist x];
    
end

hist;

T


