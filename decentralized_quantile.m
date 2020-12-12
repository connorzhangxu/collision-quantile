clear all 
clc
clf

global tau n y k

n=100;
k=10;

tau = (n-k)/n + 1/(2*n);

load graph_100.mat

%rng(1)

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

%G = G;
 
s = zeros(n,1);

T = 0;

%tic

P = [];

C = [];

for rounds = 1:100
    
    %tic
    
    J = [];
    
    c = [];
    
    x = randn(length(G),1);
    
    y = abs(x);
    
    
    %fminunc('quantile_cost_global',0);

    %z = sort(y,'descend');
    
    %z(100);
    
    %pause

    w = 0*ones(n,1);
    
    %pause

    rounds
    
    T = 0;
    
while T<500
    
    T = T+1;
   
    for i=1:n
           
        if y(i) - w(i) >= 0
            
            s(i) = -tau;
            
        elseif y(i) - w(i) < 0
            
            s(i) = 1-tau;
            
        end
       
    end
    
   %for  m = 1:100
       
        %w = ;
    
   %end
   
    
    
   a = 1;
   b = 0.51;
   
   w = G*w - (a/(T)^b)*s;
     

   %[w y boolean(round(y,4)>=round(w,4))]
  
  % w = G*w;
   
   %w(1:5)
    
   %hist = [hist x];
   
   %upper = upper + (a/(floor(T/50)+1)^b)*w;
   
   %lower = lower + (a/(floor(T/50)+1)^b);
  
   %wstar = upper/lower;
   
   %w(1:5)
    
   %sum(boolean(round(y,4)>=round(w,4)))
   
   %pause
   
   U = boolean(round(y,4)>=round(w,4));
   
   c = [c sum(U)];

    if sum(U) > k
    
        cost = sum(x.^2)/n;
    
    else 
    
        cost = sum((x.^2).*(1-U))/n;
    
    end
    
    J = [ J cost] ;
   
end

P = [P;J];

C = [C; c];

%toc

end

%data = P';






subplot(2,1,1)

%fanChart([1:1:5000], P','mean')

%plot([1:1:5000], median(P))

%plot([1:1:5000], mean(P))

 x=[1:1:500];                  %#initialize x array
 y1=mean(P)+ std(P);                      %#create first curve
 y2=mean(P)-std(P);                   %#create second curve
 X=[x,fliplr(x)];                %#create continuous x value array for plotting
 Y=[y1,fliplr(y2)];              %#create y values for out and then back
 fill(X,Y,'b');  

 hold
 
plot([1:1:500],mean(P),'w')

%hold

%plot([1:1:5000],median(P))

line([1,500],[0.5678,0.5678],'color','w')

line([1,500],[ 0.7031 ,0.7031])

 subplot(2,1,2)
% 
%fanChart([1:1:5000],C','mean')
% 
% x=[1:1:1000];                  %#initialize x array
% y1=max(C);                      %#create first curve
% y2=min(C);                   %#create second curve
% X=[x,fliplr(x)];                %#create continuous x value array for plotting
% Y=[y1,fliplr(y2)];              %#create y values for out and then back
% fill(X,Y,'b');  
% 
% hold
% 

 x=[1:1:500];                  %#initialize x array
 y1=mean(C)+ std(C);                      %#create first curve
 y2=mean(C)- std(C);                   %#create second curve
 X=[x,fliplr(x)];                %#create continuous x value array for plotting
 Y=[y1,fliplr(y2)];              %#create y values for out and then back
 fill(X,Y,'b'); 
 
 hold
 
 
 
 plot([1:1:500],mean(C))

line([1,500],[ 10 ,10])


%line([1,10000],[ 0.6206 ,0.6206])


%toc
%T
% 
% hist;
% 
% T


