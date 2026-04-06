function [x, nit] = GaussSeidel(A, b, x0, err, maxit)
    n = length(b);
    x = x0;

    for nit = 1:maxit
        x_old = x;

        for i = 1:n
            s1 = 0;
            for j = 1:i-1
                s1 = s1 + A(i,j) * x(j);
            end

            s2 = 0;
            for j = i+1:n
                s2 = s2 + A(i,j) * x_old(j);
            end

            x(i) = (b(i) - s1 - s2) / A(i,i);
        end

        if norm(x - x_old, inf) < err
            return;
        end
    end
end