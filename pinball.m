function [rho] = pinball(u)

global tau

if u >= 0
    
    rho = tau*u;
    
elseif u<0
    
    rho = (tau-1)*u;
    
end
