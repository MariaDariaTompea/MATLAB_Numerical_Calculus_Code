function yq = hermite_interp(xn, yn, dn, xq)
    % xn: nodes, yn: f(xn), dn: f'(xn), xq: query points
    n = length(xn);
    % Build doubled nodes z and h values
    z = zeros(1, 2*n);
    Q = zeros(2*n, 2*n);
    for i = 1:n
        z(2*i-1) = xn(i);
        z(2*i)   = xn(i);
        Q(2*i-1, 1) = yn(i);
        Q(2*i,   1) = yn(i);
    end
    for i = 1:n
        Q(2*i, 2) = dn(i);
    end
    for i = 2:n
        Q(2*i-1, 2) = (Q(2*i-1,1) - Q(2*i-2,1)) / (z(2*i-1) - z(2*i-2));
    end
    for j = 3:2*n
        for i = j:2*n
            Q(i,j) = (Q(i,j-1) - Q(i-1,j-1)) / (z(i) - z(i-j+1));
        end
    end
    % Evaluate using Newton's divided differences
    yq = zeros(size(xq));
    for k = 1:length(xq)
        val = Q(1,1);
        prod_term = 1;
        for j = 2:2*n
            prod_term = prod_term * (xq(k) - z(j-1));
            val = val + Q(j,j) * prod_term;
        end
        yq(k) = val;
    end
end

%[appendix]{"version":"1.0"}
%---
