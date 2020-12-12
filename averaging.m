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
              
               G(i,j) = G(i,j) - (1+max(d(i),d(l)))^-1;
               
           end
           
       end
       
       if i~=j && any(j==N_i)
          
           G(i,j) = (1+max(d(i),d(j)))^-1;
           
       end
        
    end
    
end

%G = G^10;

load threshold_gaussian_100_10.mat

P = [];

C = [];

for M = 1:100
    
M
    
x = randn(n,1);

z = x;

m = mean(z);

y = (n/(n-1))*(x).^2;

J = zeros(1,200);

c = zeros(1,200);

threshold = zeros(n,1);

%THRES = [];

for T = 1:200

    for l = 1:n
       
        if y(l) <= 10
            
            threshold(l) = T_star(floor(y(l)/0.0001)+1);
           
        else
            
            var = y(l);
            
            P0 = fzero('func',0);
             
            threshold(l) = fminsearch('threshold_symmetric',P0);
            
        end
        
       
        
    end
    
    U = boolean(abs(x)>=threshold);
    
    c(T) = sum(U);

    if sum(U) > k
    
        cost = sum(x.^2)/n;
        
    
    else 
    
        cost = sum((x.^2).*(1-U))/n;
    
    end
    
    J(T) = cost;
    
    %z = G*z;
    
    y = G*y;
    
     %THRES = [THRES threshold];
        
     %THRES(1:3,:)
    
    
   
end

P = [P; J];

C = [C; c];



end


subplot(2,1,1)

%fanChart([1:1:5000], P','mean')

%plot([1:1:5000], median(P))

%plot([1:1:5000], mean(P))

 x=[1:1:200];                  %#initialize x array
 y1=mean(P)+ std(P);                      %#create first curve
 y2=mean(P)-std(P);                   %#create second curve
 X=[x,fliplr(x)];                %#create continuous x value array for plotting
 Y=[y1,fliplr(y2)];              %#create y values for out and then back
 fill(X,Y,'b');  

 hold
 
plot([1:1:200],mean(P))

%hold

%plot([1:1:5000],median(P))

line([1,200],[0.5678,0.5678])

line([1,200],[ 0.7031 ,0.7031])

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

 x=[1:1:200];                  %#initialize x array
 y1=mean(C)+ std(C);                      %#create first curve
 y2=mean(C)- std(C);                   %#create second curve
 X=[x,fliplr(x)];                %#create continuous x value array for plotting
 Y=[y1,fliplr(y2)];              %#create y values for out and then back
 fill(X,Y,'b'); 
 
 hold
 
 
 
 plot([1:1:200],mean(C))

line([1,200],[ 10 ,10])














% % threshold = T_star(floor(var/0.0001)+1);
% % 
% % for M=1:100000
% % 
% % x = randn(n,1);
% % 
% % U = boolean(abs(x)>=threshold);
% % 
% %     if sum(U) > k
% %     
% %         cost = sum(x.^2)/n;
% %     
% %     else 
% %     
% %         cost = sum((x.^2).*(1-U))/n;
% %     
% %     end
% %     
% %     J=[J;cost];
% % 
% % 
% % %threshold = T_star(floor(var/0.0001)+1) %fminunc('threshold_symmetric',1.736)
% % 
% % 
% % end
% % 
% % mean(J)
% 
% %d = zeros(n,1);
% 
% % P = [];
% % 
% % for M=1:100
% %     
% %     M
% % 
% % % Initialization
% % 
% % x = randn(n,1);
% % 
% % y = x.^2;
% % 
% % %y=y/mean(y);
% % 
% % %pause
% % 
% % %y = d.^-1;
% % 
% % %z = v./d;
% % 
% % %v_hat = z./y;
% % 
% % %J = zeros(1,10^4);
% % 
% % %threshold = y;
% % 
% % %y_new = zeros(n,1);
% % 
% % 
% % 
% % 
% % for T=1:10
% %     
% %     %U = boolean(abs(x)>=threshold);
% % 
% %     U = boolean(abs(x)>=1.7361);
% % 
% %     
% %     if sum(U) > k
% %     
% %         cost = sum(x.^2)/n;
% %     
% %     else 
% %     
% %         cost = sum((x.^2).*(1-U))/n;
% %     
% %     end
% %     
% %     J(T)=cost;
% %     
% % %     for i=1:n
% % % 
% % %         N_i = find(A(i,:)==1);
% % % 
% % %         d_i = length(N_i);
% % %         
% % %         y_new(i) = y(i)*(1-d_i/d_max) + sum(y(N_i))/d_max; 
% % % 
% % %     end
% %     
% % %   y = y_new;
% % 
% 
% 
% y = G*y;
%     
%     for l = 1:n
%        
%         if y(l) <= 10
%             
%             threshold(l) = T_star(floor(y(l)/0.0001)+1);
%            
%         else
%             
%              P0 = fzero('func',0);
%              
%              var = y(l);
%     
%              threshold(l) = fminsearch('threshold_symmetric',P0);
%             
%         end
%         
%     end
%         
% end
% 
% P = [P; J];
% 
% end
% 
% fanChart([1:10],P')
% 
% hold
% 
% line([1,10],[ 0.6213 ,0.6213])




