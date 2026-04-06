%% TEST 1a: simple nodes x0=0, x1=1, x2=2
fprintf('\n>>> TEST 1a: f(x)=1/(1+x), nodes [0, 1, 2]\n');
x1 = [0, 1, 2];
f1 = 1 ./ (1 + x1);
D1 = divided_diff_table(x1, f1);

%% TEST 1c: 11 equidistant nodes on [1, 2]
fprintf('\n>>> TEST 1c: f(x)=1/(1+x), 11 equidistant nodes on [1,2]\n');
x2 = linspace(1, 2, 11);
f2 = 1 ./ (1 + x2);
D2 = divided_diff_table(x2, f2);

%% Verification at x = 1.5
fprintf('\n>>> Verification at x = 1.5:\n');
x_test = 1.5;
f_exact = 1 / (1 + x_test);

n = length(x2);
p = D2(1, n);
for k = n-1:-1:1
    p = D2(1, k) + (x_test - x2(k)) * p;
end

fprintf('  f(1.5) exact  = %.10f\n', f_exact);
fprintf('  P(1.5) approx = %.10f\n', p);
fprintf('  Error         = %.2e\n', abs(f_exact - p));

%% TEST 1b: double nodes x0=0, x1=1, x2=2
% f(x) = 1/(1+x)   =>  f'(x) = -1/(1+x)^2

fprintf('\n>>> TEST 1b: f(x)=1/(1+x), DOUBLE nodes [0, 1, 2]\n');

x  = [0, 1, 2];
f  = 1 ./ (1 + x);          % f values:  [1, 0.5, 1/3]
df = -1 ./ (1 + x).^2;      % f' values: [-1, -0.25, -1/9]

fprintf('\nFunction values:   '); fprintf('%.6f  ', f);  fprintf('\n');
fprintf('Derivative values: '); fprintf('%.6f  ', df); fprintf('\n');

D = divided_diff_table_double(x, f, df);

%% Verification at x = 0.5
fprintf('\n>>> Verification at x = 0.5:\n');
x_test = 0.5;
f_exact = 1 / (1 + x_test);

% Expanded node vector
t = [0,0, 1,1, 2,2];
N = length(t);

% Evaluate Newton polynomial (Horner)
p = D(1, N);
for k = N-1:-1:1
    p = D(1, k) + (x_test - t(k)) * p;
end

fprintf('  f(0.5) exact  = %.10f\n', f_exact);
fprintf('  P(0.5) approx = %.10f\n', p);
fprintf('  Error         = %.2e\n', abs(f_exact - p));