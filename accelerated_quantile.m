clear all
clc
clf

global var n k

n = 100;
k = 10;
var = 1;

load graph_100.mat

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

load threshold_gaussian_100_10.mat

P1 = [];

P2 = [];

C = 1;

G = G^C;

for M = 1:100

M

%%%%% Switching time %%%%%%

%d_max = max(sum(A));

% R = 0;
% 
% eta = 0.0001;
% 
% t = 0;
% 
% while R == 0
% 
%     if svds(G^t - ones(n,n)/n,1) <= eta
%         
%         R = t;
%         break
%         
%     else
%         
%         t=t+1
%         
%     end
%     
% end



% R = 0 ;

R = 0;

% R = 480;
% R = 960
% R = 1440
% R = 1920



%%%%%%%%%%%%%%

x = randn(n,1);

y = (n/(n-1))*(x).^2;

threshold = 0*ones(n,1);



J1 = [];

for T = 1:R

    for l = 1:n
       
        if y(l) <= 10
            
            threshold(l) = T_star(floor(y(l)/0.0001)+1);
           
        else
            
            P0 = fzero('func',0);
             
            var = y(l);
    
            threshold(l) = fminsearch('threshold_symmetric',P0);
            
        end
        
    end
    
    U = boolean(abs(x)>=threshold);

    if sum(U) > k
    
        cost = sum(x.^2)/n;
    
    else 
    
        cost = sum((x.^2).*(1-U))/n;
    
    end
    
    J1 =[J1 cost];
        
    y = G*y;
   
end

w = threshold;

y = abs(x);

tau = (n-k)/n +1/(2*n);

s = zeros(n,1);

for T=1:500-R
   
    for i=1:n
           
        if y(i) - w(i) >= 0
            
            s(i) = -tau;
            
        elseif y(i) - w(i) < 0
            
            s(i) = (1-tau);
            
        end
       
    end
    
   a = 1;
   b = 0.51;
   
   w = G*w - (a/(T)^b)*s;
   
   %w = G*w;
    
   U = boolean(round(y,4)>=round(w,4));
   
    if sum(U) > k
    
        cost = sum(x.^2)/n;
    
    else 
    
        cost = sum((x.^2).*(1-U))/n;
    
    end
    
    J1 = [ J1 cost] ;
   
end

P1 = [P1;J1];


%threshold = zeros(n,1);


% J2 = [];
% 
% for T = 1:R/C
% 
%     for l = 1:n
%        
%         if y(l) <= 10
%             
%             threshold(l) = T_star(floor(y(l)/0.0001)+1);
%            
%         else
%             
%             P0 = fzero('func',0);
%              
%             var = y(l);
%     
%             threshold(l) = fminsearch('threshold_symmetric',P0);
%             
%         end
%         
%     end
%     
%     U = boolean(abs(x)>=threshold);
% 
%     if sum(U) > k
%     
%         cost = sum(x.^2)/n;
%     
%     else 
%     
%         cost = sum((x.^2).*(1-U))/n;
%     
%     end
%     
%     J2 =[J2 cost];
%         
%     y = G*y;
%    
% end
% 
% w = threshold;
% 
% y = abs(x);
% 
% tau = (n-k+1)/n;
% 
% s = zeros(n,1);
% 
% for T=1:2000
%    
%     for i=1:n
%            
%         if y(i) - w(i) >= 0
%             
%             s(i) = -tau;
%             
%         elseif y(i) - w(i) < 0
%             
%             s(i) = (1-tau);
%             
%         end
%        
%     end
%     
%    a = 1;
%    b = 0.51;
%    
%    w = w - (a/(T)^b)*s;
%    
%    w = G*w;
%     
%    U = boolean(round(y,4)>=round(w,4));
%    
%     if sum(U) > k
%     
%         cost = sum(x.^2)/n;
%     
%     else 
%     
%         cost = sum((x.^2).*(1-U))/n;
%     
%     end
%     
%     J2 = [ J2 cost] ;
%    
% end
% 
% P2 = [P2;J2];


end

x=[1:1:500];                  %#initialize x array
 y1=mean(P1)+ std(P1);                      %#create first curve
 y2=mean(P1)-std(P1);                   %#create second curve
 X=[x,fliplr(x)];                %#create continuous x value array for plotting
 Y=[y1,fliplr(y2)];              %#create y values for out and then back
 fill(X,Y,'b');  

 hold
 
plot([1:1:500],mean(P1),'w')

%fanChart([1:C:length(P1)*C],P1','mean')
%plot([1:C:length(J)*C],J)

% hold

%fanChart([1:C:length(P2)*C],P2')

line([1,500],[0.5678,0.5678],'color','w')

line([1,500],[ 0.7031 ,0.7031])

