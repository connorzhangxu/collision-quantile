function [J] = quantile_cost_global(q)

global n tau y

J = 0;

for i = 1:n
    
    J = J + pinball(y(i)-q)/n;
    
end

end