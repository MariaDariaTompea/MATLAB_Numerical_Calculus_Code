clc
clear

A = [2 1 -1 -2;
     4 4 1 3;
    -6 -1 10 10;
    -2 1 8 4];

b = [2;4;-5;1];

n = length(b);

for k = 1:n-1
    
    % Partial pivoting
    [~,m] = max(abs(A(k:n,k)));
    m = m + k - 1;
    
    % Swap rows
    A([k m],:) = A([m k],:);
    b([k m]) = b([m k]);
    
    % Elimination
    for i = k+1:n
        factor = A(i,k)/A(k,k);
        A(i,k:n) = A(i,k:n) - factor*A(k,k:n);
        b(i) = b(i) - factor*b(k);
    end
end

% Solve using back substitution
x = backsub(A,b);

disp('Solution:')
disp(x)