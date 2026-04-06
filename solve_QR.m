function x = solve_QR(A,b)

[Q,R] = qr(A);

x = R\(Q'*b);

end