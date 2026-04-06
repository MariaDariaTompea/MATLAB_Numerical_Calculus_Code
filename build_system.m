function [A, b] = build_system(n)
    % Builds the tridiagonal system of size n
    A = zeros(n, n);
    b = 3 * ones(n, 1);

    % First equation
    A(1,1) = 5;
    A(1,2) = -1;
    b(1) = 4;

    % Middle equations
    for i = 2:n-1
        A(i,i-1) = -1;
        A(i,i) = 5;
        A(i,i+1) = -1;
    end

    % Last equation
    A(n,n-1) = -1;
    A(n,n) = 5;
    b(n) = 4;
end