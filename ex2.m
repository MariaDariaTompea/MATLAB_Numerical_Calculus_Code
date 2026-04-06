clc; clear;

% Original system
A = [10 7 8 7;
     7 5 6 5;
     8 6 10 9;
     7 5 9 10];

b = [32; 23; 33; 31];

% Solve original system
x = solve_system2(A, b);
disp('Original solution x:');
disp(x);

% ---- (b) Perturb b ----
b_tilde = [32.1; 22.9; 33.1; 30.9];

x_tilde_b = solve_system2(A, b_tilde);

input_err_b = relative_error2(b_tilde, b);
output_err_b = relative_error2(x_tilde_b, x);

disp('--- Perturbed b ---');
disp('Solution x_tilde:');
disp(x_tilde_b);
disp(['Input relative error: ', num2str(input_err_b)]);
disp(['Output relative error: ', num2str(output_err_b)]);

% ---- (c) Perturb A ----
A_tilde = [10 7 8.1 7.2;
           7.8 5.04 6 5;
           8 5.98 9.89 9;
           6.99 4.99 9 9.98];

x_tilde_A = solve_system2(A_tilde, b);

input_err_A = norm(A_tilde - A) / norm(A);
output_err_A = relative_error2(x_tilde_A, x);

disp('--- Perturbed A ---');
disp('Solution x_tilde:');
disp(x_tilde_A);
disp(['Input relative error: ', num2str(input_err_A)]);
disp(['Output relative error: ', num2str(output_err_A)]);