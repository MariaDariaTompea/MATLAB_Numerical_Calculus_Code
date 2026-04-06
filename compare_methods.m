clc
clear

% Define matrix A and vector b
A = [2 1 -1 -2;
     4 4 1 3;
    -6 -1 10 10;
    -2 1 8 4];

b = [2;4;-5;1];

fprintf('===== Comparison of Linear System Solvers =====\n\n');

%% Gaussian Elimination
tic
x_gauss = gaussian_elimination(A,b);
t_gauss = toc;

res_gauss = norm(A*x_gauss - b);

fprintf('--- Gaussian Elimination ---\n');
disp('Solution:')
disp(x_gauss)
fprintf('Residual error: %e\n',res_gauss);
fprintf('Time: %f seconds\n\n',t_gauss);

%% LUP Factorization
tic
x_lup = solve_LUP(A,b);
t_lup = toc;

res_lup = norm(A*x_lup - b);

fprintf('--- LUP Factorization ---\n');
disp('Solution:')
disp(x_lup)
fprintf('Residual error: %e\n',res_lup);
fprintf('Time: %f seconds\n\n',t_lup);

%% QR Factorization
tic
x_qr = solve_QR(A,b);
t_qr = toc;

res_qr = norm(A*x_qr - b);

fprintf('--- QR Factorization ---\n');
disp('Solution:')
disp(x_qr)
fprintf('Residual error: %e\n',res_qr);
fprintf('Time: %f seconds\n\n',t_qr);

%% Summary
fprintf('===== Summary =====\n');
fprintf('Method\t\tResidual\t\tTime\n');
fprintf('Gaussian\t%e\t%f\n',res_gauss,t_gauss);
fprintf('LUP\t\t%e\t%f\n',res_lup,t_lup);
fprintf('QR\t\t%e\t%f\n',res_qr,t_qr);