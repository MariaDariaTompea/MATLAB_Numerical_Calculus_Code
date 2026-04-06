clc
clear

A = [2 1 -1 -2;
     4 4 1 3;
    -6 -1 10 10;
    -2 1 8 4];

b = [2;4;-5;1];

[L,U,P] = lu(A);

y = L\(P*b);
x = U\y;

disp('Solution using LUP:')
disp(x)