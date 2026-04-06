clc;
clear;

n = 1000;

A = 5*eye(n) - diag(ones(n-1,1),1) - diag(ones(n-1,1),-1);

b = 3*ones(n,1);
b(1) = 4;
b(n) = 4;

x0 = zeros(n,1);

err = 1e-5;
maxnit = 10000;

fprintf("System size: n = %d\n\n", n);

fprintf("First 5 elements of b:\n");
disp(b(1:5))

%% Jacobi
[x_jacobi, nit_j] = jacobi(A,b,x0,err,maxnit);

fprintf("\nJacobi method:\n");
fprintf("Iterations: %d\n", nit_j);
fprintf("First 5 values of solution:\n");
disp(x_jacobi(1:5))

%% Gauss-Seidel
[x_gs, nit_gs] = gauss_seidel(A,b,x0,err,maxnit);

fprintf("\nGauss-Seidel method:\n");
fprintf("Iterations: %d\n", nit_gs);
fprintf("First 5 values of solution:\n");
disp(x_gs(1:5))