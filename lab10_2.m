% lab10_2.m
% Approximate area under f(x) = x*e^(-x) / (x^2 + 1) on [0,1]
% Using rectangle, trapezoidal, and Simpson's composite rules
% for n = 2, 4, 8, 16, ..., 256

clear; clc;

a = 0; b = 1;
f = @(x) x .* exp(-x) ./ (x.^2 + 1);

%% Part a: Plot the function
figure;
xx = linspace(a, b, 500);
plot(xx, f(xx), 'b-', 'LineWidth', 2);
xlabel('x'); ylabel('f(x)');
title('f(x) = x e^{-x} / (x^2 + 1)  on [0, 1]');
grid on;

%% Part b: Approximate with composite rules and compute errors

% Use a very fine reference value as "exact"
n_ref = 2^20;
h_ref = (b - a) / n_ref;
xi_ref = a:h_ref:b;
w_ref = ones(1, n_ref+1);
w_ref(2:2:end-1) = 4;
w_ref(3:2:end-2) = 2;
exact = (h_ref/3) * sum(w_ref .* f(xi_ref));

fprintf('Reference (exact) value: %.15f\n\n', exact);

ns = 2.^(1:8);  % n = 2, 4, 8, ..., 256

err_rect = zeros(size(ns));
err_trap = zeros(size(ns));
err_simp = zeros(size(ns));

fprintf('%-6s %-18s %-12s %-18s %-12s %-18s %-12s\n', ...
    'n', 'Rectangle', 'Err_Rect', 'Trapezoid', 'Err_Trap', 'Simpson', 'Err_Simp');
fprintf('%s\n', repmat('-', 1, 100));

for k = 1:length(ns)
    n = ns(k);
    h = (b - a) / n;
    xi = a:h:b;

    % Midpoint rule
    xm = a + h/2 : h : b - h/2;
    Irect = h * sum(f(xm));

    % Trapezoidal rule
    Itrap = h * (f(a)/2 + sum(f(xi(2:end-1))) + f(b)/2);

    % Simpson's rule
    w = ones(1, n+1);
    w(2:2:end-1) = 4;
    w(3:2:end-2) = 2;
    Isimp = (h/3) * sum(w .* f(xi));

    err_rect(k) = abs(Irect - exact);
    err_trap(k) = abs(Itrap - exact);
    err_simp(k) = abs(Isimp - exact);

    fprintf('n=%-4d  Rect=%.10f  Err=%.3e   Trap=%.10f  Err=%.3e   Simp=%.10f  Err=%.3e\n', ...
        n, Irect, err_rect(k), Itrap, err_trap(k), Isimp, err_simp(k));
end

%% Ratios of consecutive errors (should be ~4 for trap, ~16 for Simpson)
fprintf('\n--- Error Ratios (err(n) / err(2n)) ---\n');
fprintf('%-6s %-15s %-15s %-15s\n', 'n->2n', 'Rect ratio', 'Trap ratio', 'Simp ratio');
fprintf('%s\n', repmat('-', 1, 55));
for k = 1:length(ns)-1
    fprintf('%-4d->%-4d  %10.4f      %10.4f      %10.4f\n', ...
        ns(k), ns(k+1), ...
        err_rect(k)/err_rect(k+1), ...
        err_trap(k)/err_trap(k+1), ...
        err_simp(k)/err_simp(k+1));
end

fprintf('\nTheoretical ratios: Rectangle~4, Trapezoid~4, Simpson~16\n');

%% Log-log plot of errors
figure;
loglog(ns, err_rect, 'r-o', ns, err_trap, 'b-s', ns, err_simp, 'g-^', 'LineWidth', 2);
legend('Rectangle', 'Trapezoid', 'Simpson');
xlabel('n (number of subintervals)');
ylabel('Absolute error');
title('Convergence of composite quadrature rules');
grid on;