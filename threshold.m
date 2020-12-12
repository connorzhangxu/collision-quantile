clear all
clc

T_opt_fix = [];

global var

i=0;

%options = optimset('Tolf',1e-7,'tolx',1e-8)

for var=0.0001:0.0001:10
    
    i = 1+i
   
    P0 = fzero('func',0);
    
    T_opt_fix = [T_opt_fix fminsearch('threshold_symmetric',P0)];
    
end

T_star = [0 T_opt_fix];

plot([0:0.0001:10],T_star)

save('threshold_gaussian_100_10.mat','T_star')

