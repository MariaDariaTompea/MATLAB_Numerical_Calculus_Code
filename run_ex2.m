%% Exercise 2 - Given data
x = [-2, -1, 0, 1, 2, 3, 4];
f = [-5,  1, 1, 1, 7, 25, 60];

fprintf('Data:\n');
fprintf('x: '); fprintf('%6.1f ', x); fprintf('\n');
fprintf('f: '); fprintf('%6.1f ', f); fprintf('\n');

%% a) Divided differences table
D = divided_diff_table(x, f);

%% b) & c) Forward and Backward differences tables
% (nodes are equidistant with h=1, so finite differences apply directly)
[FWRD, BKWD] = finite_diff_tables(f);

%% Verification - Newton forward polynomial at x=0.5
fprintf('\n>>> Verification: Newton interpolation at x = 0.5\n');
h = 1;
x0 = x(1);  % = -2
t = (0.5 - x0) / h;  % normalized variable

n = length(x);
p = 0;
binom = 1;
for k = 1:n
    if k > 1
        binom = binom * (t - (k-1)) / k;
    else
        binom = 1;
    end
    p = p + FWRD(1, k) * binom;
end

fprintf('  P(0.5) = %.6f\n', p);