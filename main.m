% Main script to run Jacobi and Gauss-Seidel methods

n = 1000;
[A, b] = build_system(n);

% Initial guess, tolerance, and max iterations
x0 = zeros(n,1);
err = 1e-5;
maxit = 10000;

% Jacobi method
[x_jacobi, nit_jacobi] = Jacobi(A, b, x0, err, maxit);

% Gauss-Seidel method
[x_gs, nit_gs] = GaussSeidel(A, b, x0, err, maxit);

% Display results
fprintf('Jacobi iterations: %d\n', nit_jacobi);
fprintf('Gauss-Seidel iterations: %d\n', nit_gs);