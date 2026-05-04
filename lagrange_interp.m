function yq = lagrange_interp(xn, yn, xq)
    n = length(xn);
    yq = zeros(size(xq));
    for i = 1:n
        L = ones(size(xq));
        for j = 1:n
            if j ~= i
                L = L .* (xq - xn(j)) / (xn(i) - xn(j));
            end
        end
        yq = yq + yn(i) * L;
    end
end

%[appendix]{"version":"1.0"}
%---
