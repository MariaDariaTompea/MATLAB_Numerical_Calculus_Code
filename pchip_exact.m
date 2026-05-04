function pp = pchip_exact(x, y, d)
    % Builds a piecewise cubic Hermite pp struct from nodes x,
    % function values y, and exact derivatives d.
    n = length(x) - 1;   % number of intervals
    coefs = zeros(n, 4);
    for k = 1:n
        h  = x(k+1) - x(k);
        y0 = y(k);   y1 = y(k+1);
        d0 = d(k);   d1 = d(k+1);
        % Hermite basis coefficients (local t = x - x_k)
        % p(t) = a + b*t + c*t^2 + d_coef*t^3
        a = y0;
        b = d0;
        c = (3*(y1-y0)/h - 2*d0 - d1) / h;
        dcoef = (2*(y0-y1)/h + d0 + d1) / h^2;
        coefs(k,:) = [dcoef, c, b, a];
    end
    pp = mkpp(x, coefs);
end

%[appendix]{"version":"1.0"}
%---
