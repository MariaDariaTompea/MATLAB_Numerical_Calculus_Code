clc; clear;

% known points
x = [100 121 144];
y = [10 11 12];

% value to approximate
x_val = 118;

n = length(x);
L = 0;

% Lagrange interpolation
for i = 1:n
    term = y(i);
    for j = 1:n
        if i ~= j
            term = term * (x_val - x(j)) / (x(i) - x(j));
        end
    end
    L = L + term;
end

fprintf('Approximation of sqrt(118): %.6f\n', L);

% exact value (for comparison)
exact = sqrt(118);
fprintf('Exact value: %.6f\n', exact);
fprintf('Error: %.6f\n', abs(L - exact));