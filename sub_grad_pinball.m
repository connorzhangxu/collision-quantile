function [s] = sub_grad_pinball(y,w)

global tau 

if y - w > 0
    
    s = -tau;
    
elseif y - w < 0
    
    s = (1-tau);
    
elseif y - w == 0
    
    s = 0;
    
end

