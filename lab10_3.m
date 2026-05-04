% lab10_3.m
% Tabulate erf(x) for x = 0.1, 0.2, ..., 1.0
% using adaptive trapezoidal quadrature
% Compare with MATLAB built-in integral() and erf()

clear; clc;

g      = @(t) exp(-t.^2);
prefix = 2 / sqrt(pi);

x_vals = 0.1 : 0.1 : 1.0;
tol    = 1e-10;

n_points     = length(x_vals);
erf_adaptive = zeros(1, n_points);
erf_integral = zeros(1, n_points);
erf_builtin  = zeros(1, n_points);

for i = 1:n_points
    x = x_vals(i);
    erf_adaptive(i) = prefix * adapt_trap(g, 0, x, tol);
    erf_integral(i) = prefix * integral(g, 0, x);
    erf_builtin(i)  = erf(x);
end

%% Display results
fprintf('%-6s %-18s %-18s %-18s %-15s %-15s\n', ...
    'x', 'Adaptive Trap', 'integral()', 'erf()', ...
    'Err vs erf()', 'Err vs integral');
fprintf('%s\n', repmat('-', 1, 95));

for i = 1:n_points
    fprintf('x=%.1f  %.12f  %.12f  %.12f  %.3e       %.3e\n', ...
        x_vals(i), erf_adaptive(i), erf_integral(i), erf_builtin(i), ...
        abs(erf_adaptive(i) - erf_builtin(i)), ...
        abs(erf_adaptive(i) - erf_integral(i)));
end

%% Plot
figure;
plot(x_vals, erf_builtin,   'k-',  'LineWidth', 2.5); hold on;
plot(x_vals, erf_integral,  '--',  'Color', [0.2 0.7 0.2], 'LineWidth', 2, 'Marker', 's', 'MarkerSize', 7);
plot(x_vals, erf_adaptive,  'r-o', 'LineWidth', 1.5, 'MarkerSize', 7); hold off;
legend('erf()  [exact]', 'integral()', 'Adaptive Trapezoid', 'Location', 'northwest');
xlabel('x'); ylabel('erf(x)');
title('Error Function erf(x): comparison of methods');
grid on;


%% ---- Iterative adaptive trapezoidal (no recursion) ----
function I = adapt_trap(f, a, b, tol)
% Uses an explicit stack instead of recursion to avoid out-of-memory errors.
    stack = [a, b, tol];
    I = 0;
    while ~isempty(stack)
        lo = stack(end,1);
        hi = stack(end,2);
        lt = stack(end,3);
        stack(end,:) = [];

        m        = (lo + hi) / 2;
        flo = f(lo); fhi = f(hi); fm = f(m);
        I_coarse = (hi - lo) / 2 * (flo + fhi);
        I_fine   = (hi - lo) / 4 * (flo + 2*fm + fhi);

        if abs(I_fine - I_coarse) <= 3 * lt || (hi - lo) < 1e-13
            % Richardson-corrected result for this subinterval
            I = I + I_fine + (I_fine - I_coarse) / 3;
        else
            stack(end+1,:) = [lo, m,  lt/2];
            stack(end+1,:) = [m,  hi, lt/2];
        end
    end
end