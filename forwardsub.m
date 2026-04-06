function y = forwardsub(L,b)

n = length(b);
y = zeros(n,1);

for i = 1:n
    s = 0;
    
    for j = 1:i-1
        s = s + L(i,j)*y(j);
    end
    
    y(i) = (b(i) - s)/L(i,i);
end

end