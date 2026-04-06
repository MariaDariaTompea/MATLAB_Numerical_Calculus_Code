function x = solve_LUP(A,b)

[L,U,P] = lu(A);     % LUP factorization

y = L\(P*b);         % forward substitution
x = U\y;             % back substitution

end