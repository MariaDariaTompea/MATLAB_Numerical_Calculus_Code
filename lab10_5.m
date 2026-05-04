% lab10_5.m
% Optional: Simpson's rule on I = integral_0^1 sin(x^(1/3)) dx
% Part a: apply composite Simpson for n = 2,4,8,...,256, compute errors & ratios
% Part b: substitute t = x^(1/3) => x = t^3, dx = 3t^2 dt
%         I = integral_0^1 sin(t) * 3t^2 dt  (smooth integrand, no singularity)

clear; clc;

a = 0; b = 1;
f = @(x) sin(x.^(1/3));

%% Reference value via high-accuracy built-in
exact = integral(f, 0, 1, 'AbsTol', 1e-14, 'RelTol', 1e-14);
fprintf('Reference value of I: %.15f\n\n', exact);

ns = 2.^(1:8);  % n = 2, 4, 8, ..., 256
err_a = zeros(size(ns));

fprintf('=== Part a: Composite Simpson on sin(x^(1/3)) ===\n');
fprintf('%-6s %-20s %-15s\n', 'n', 'Approx', 'Error');
fprintf('%s\n', repmat('-',1,45));

for k = 1:length(ns)
    n = ns(k);
    h = (b - a) / n;
    xi = a:h:b;
    w = ones(1, n+1);
    w(2:2:end-1) = 4;
    w(3:2:end-2) = 2;
    Isimp = (h/3) * sum(w .* f(xi));
    err_a(k) = abs(Isimp - exact);
    fprintf('n=%-4d  %.15f  %.3e\n', n, Isimp, err_a(k));
end

fprintf('\n--- Error Ratios (err(n)/err(2n)) for Part a ---\n');
fprintf('%-12s %-12s\n', 'n -> 2n', 'Ratio');
fprintf('%s\n', repmat('-',1,26));
for k = 1:length(ns)-1
    fprintf('%4d -> %-4d   %.4f\n', ns(k), ns(k+1), err_a(k)/err_a(k+1));
end
fprintf('\nNote: ratios should be ~16 for smooth f, but sin(x^1/3) has\n');
fprintf('      derivative singularity at x=0, so convergence is much slower.\n\n');

%% Part b: substitution t = x^(1/3), so x=t^3, dx=3t^2 dt
% I = integral_0^1 sin(t) * 3*t^2 dt  (smooth integrand)
g = @(t) 3 * t.^2 .* sin(t);
exact_g = integral(g, 0, 1, 'AbsTol', 1e-14);

fprintf('=== Part b: After substitution t=x^(1/3): integral of 3t^2*sin(t) ===\n');
fprintf('Reference value: %.15f  (should match part a: %.15f)\n\n', exact_g, exact);

err_b = zeros(size(ns));

fprintf('%-6s %-20s %-15s\n', 'n', 'Approx', 'Error');
fprintf('%s\n', repmat('-',1,45));

for k = 1:length(ns)
    n = ns(k);
    h = 1 / n;
    ti = 0:h:1;
    w = ones(1, n+1);
    w(2:2:end-1) = 4;
    w(3:2:end-2) = 2;
    Isimp = (h/3) * sum(w .* g(ti));
    err_b(k) = abs(Isimp - exact);
    fprintf('n=%-4d  %.15f  %.3e\n', n, Isimp, err_b(k));
end

fprintf('\n--- Error Ratios (err(n)/err(2n)) for Part b ---\n');
fprintf('%-12s %-12s\n', 'n -> 2n', 'Ratio');
fprintf('%s\n', repmat('-',1,26));
for k = 1:length(ns)-1
    fprintf('%4d -> %-4d   %.4f\n', ns(k), ns(k+1), err_b(k)/err_b(k+1));
end
fprintf('\nNote: ratios should now be ~16 (theoretical for Simpson on smooth f).\n');

%% Log-log plot comparison
figure;
% Data lines: solid, thick, distinct colors
loglog(ns, err_a, 'r-o', 'LineWidth', 2, 'MarkerSize', 8, 'DisplayName', 'Part a: direct sin(x^{1/3})');
hold on;
loglog(ns, err_b, 'b-s', 'LineWidth', 2, 'MarkerSize', 8, 'DisplayName', 'Part b: after substitution');

% Reference lines: dashed, different colors from data lines
ref_line_a = err_a(1) * (ns(1)./ns).^(4/3);
ref_line_b = err_b(2) * (ns(2)./ns).^4;
loglog(ns, ref_line_a, '--', 'Color', [0.85 0.5 0], 'LineWidth', 1.5, 'DisplayName', '~n^{-4/3} ref (slow)');
loglog(ns, ref_line_b, '--', 'Color', [0.2 0.7 0.2], 'LineWidth', 1.5, 'DisplayName', '~n^{-4} ref (Simpson)');

xlabel('n'); ylabel('Absolute error');
title('Simpson convergence: direct vs substituted integrand');
legend('Location', 'southwest');
grid on;