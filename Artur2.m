clc;
clear;

A = [10 7 8 7;
     7 5 6 5;
     8 6 10 9;
     7 5 9 10];

b = [32;23;33;31];

%% ===============================
%% a) Solve Ax = b
%% ===============================

fprintf("a) Original system solution:\n");

x = A\b;
disp(x)

condA = cond(A);
fprintf("Condition number of A: %e\n", condA);

%% ===============================
%% b) Perturb b
%% ===============================

b_tilde = [32.1;22.9;33.1;30.9];

x_tilde = A\b_tilde;

fprintf("\nb) Solution with perturbed b:\n");
disp(x_tilde)

rel_input_b = norm(b_tilde - b)/norm(b);
rel_output_b = norm(x_tilde - x)/norm(x);

fprintf("Relative input error (b): %e\n", rel_input_b);
fprintf("Relative output error (x): %e\n", rel_output_b);

% same matrix → same condition number
fprintf("Condition number of A (same matrix): %e\n", condA);

%% ===============================
%% c) Perturb A
%% ===============================

A_tilde = [10 7 8.1 7.2;
           7.8 5.04 6 5;
           8 5.98 9.89 9;
           6.99 4.99 9 9.98];

x_tilde2 = A_tilde\b;

fprintf("\nc) Solution with perturbed A:\n");
disp(x_tilde2)

rel_input_A = norm(A_tilde - A,'fro')/norm(A,'fro');
rel_output_A = norm(x_tilde2 - x)/norm(x);

fprintf("Relative input error (A): %e\n", rel_input_A);
fprintf("Relative output error (x): %e\n", rel_output_A);

condA_tilde = cond(A_tilde);
fprintf("Condition number of A_tilde: %e\n", condA_tilde);
%% ===============================
%% d) Numerical demonstration
%% ===============================

fprintf("\nd) Numerical demonstration of sensitivity:\n");

fprintf("\nOriginal solution x:\n");
disp(x)

fprintf("Solution with perturbed b (x_tilde):\n");
disp(x_tilde)

fprintf("Solution with perturbed A (x_tilde2):\n");
disp(x_tilde2)

fprintf("\nDifferences:\n");

fprintf("||x_tilde - x|| = %e\n", norm(x_tilde - x));
fprintf("||x_tilde2 - x|| = %e\n", norm(x_tilde2 - x));

fprintf("\nRelative differences:\n");

fprintf("Relative change (b): %e\n", norm(x_tilde - x)/norm(x));
fprintf("Relative change (A): %e\n", norm(x_tilde2 - x)/norm(x));