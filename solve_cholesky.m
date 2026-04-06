function x = solve_cholesky(A,b)

L = chol(A,'lower');   % Cholesky factorization

y = L\b;               % forward substitution
x = L'\y;              % back substitution

end