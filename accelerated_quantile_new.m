clear all
clc
clf

global tau n k var

n=100;
k=10;

H = 100000;

tau = (n-k)/n + 1/(2*n);

load graph_100_2.mat

load threshold_gaussian_100_10.mat

rng(1)

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

G = G;

%pause

s = zeros(n,1);

T = 0;

%tic

P = [];

C = [];

for rounds = 1:100
    
    %tic
    
    J = [];
    
    c = [];
    
    % Set switching time
    
    R = 0;
    %R = 22;

    
    % Gaussian
    x = randn(n,1);
    
    % Laplace
    %x = laprnd(n,1);
    
    y = (x).^2;
    
    threshold = 100*ones(n,1);
    
    %threshold = abs(x);
    
    for T = 1:R
        
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
        
        if sum(U) > k
            
            cost = sum(x.^2)/n;
            
        else
            
            cost = sum((x.^2).*(1-U))/n;
            
        end
        
        J = [J cost];
        
        c = [c sum(U)];
        
        y = G*y;
        
    end
    
    for l = 1:n
        
        if y(l) <= 10
            
            threshold(l) = T_star(floor(y(l)/0.0001)+1);
            
        else
            
            
            var = y(l);
            
            P0 = fzero('func',0);
           
            threshold(l) = fminsearch('threshold_symmetric',P0);
            
        end
        
    end
    
    w = threshold;
   
    z = abs(x);
    
    rounds
    
    T = 0;
    
    while T<H-R
        
        T = T+1;
        
        for i=1:n
            
            if z(i) - w(i) >= 0
                
                s(i) = -tau;
                
            elseif z(i) - w(i) < 0
                
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
        
        %w = G*w;
        
        %w(1:5)
        
        %hist = [hist x];
        
        %upper = upper + (a/(floor(T/50)+1)^b)*w;
        
        %lower = lower + (a/(floor(T/50)+1)^b);
        
        %wstar = upper/lower;
        
        %w(1:5)
        
        %sum(boolean(round(y,4)>=round(w,4)))
        
        %pause
        
        U = boolean(round(z,4)>=round(w,4));
        
        c = [c sum(U)];
        
        if sum(U) > k
            
            cost = sum(x.^2)/n;
            
        else
            
            cost = sum((x.^2).*(1-U))/n;
            
        end
        
        J = [J cost] ;
        
    end
    
    P = [P;J];
    
    C = [C;c];
    
    %toc
    
end

%data = P';






subplot(2,1,1)

%fanChart([1:1:5000], P','mean')

%plot([1:1:5000], median(P))

%plot([1:1:5000], mean(P))

x=[1:1:H];                  %#initialize x array
y1=mean(P)+ std(P);                      %#create first curve
y2=mean(P)-std(P);                   %#create second curve
X=[x,fliplr(x)];                %#create continuous x value array for plotting
Y=[y1,fliplr(y2)];              %#create y values for out and then back
fill(X,Y,'b');

hold

plot([1:1:H],mean(P),'w')

%plot([1:1:H],P,'k')


%hold

%plot([1:1:5000],median(P))

%line([1,H],[0.4149,0.4149],'color','w')

%line([1,H],[ 0.7031 ,0.7031])

%line([1,H],[0.5958,0.5958])
line([1,H],[0.5678,0.5678])

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
 %hold
%

x=[1:1:H];                  %#initialize x array
y1=mean(C)+ std(C);                      %#create first curve
y2=mean(C)- std(C);                   %#create second curve
X=[x,fliplr(x)];                %#create continuous x value array for plotting
Y=[y1,fliplr(y2)];              %#create y values for out and then back
fill(X,Y,'b');

hold



plot([1:1:H],mean(C),'w')

%plot([1:1:H],C,'k')


line([1,H],[ 10 ,10])


%line([1,H],[ 0.6206 ,0.6206])


%toc
%T
%
% hist;
%
% T


