% Graph plots

load(graph_10.mat)

n = length(A);

for i = 1:n
    
    for j = 1:n
        
        if norm([x(i)-x(j),y(i)-y(j)],2)<=r
            
            A(i,j)=1;
            
            line([x(i),x(j)],[y(i),y(j)])
            
        end
        
    end
    
end