function [x, nit] = Jacobi(A, b, x0, err, maxit)
    n = length(b);
    x = x0;
    x_new = zeros(n,1);

    for nit = 1:maxit
        for i = 1:n
            s = 0;
            for j = 1:n
                if j ~= i
                    s = s + A(i,j) * x(j);
                end
            end
            x_new(i) = (b(i) - s) / A(i,i);
        end

        if norm(x_new - x, inf) < err
            x = x_new;
            return;
        end

        x = x_new;
    end
end