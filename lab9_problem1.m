clear; clc; close all;

% --- Setup ---
a = -2; b = 4;
n_nodes = 7;
xn = linspace(a, b, n_nodes);   % 7 equally spaced nodes
yn = f(xn);                      % f values at nodes
dn = numerical_deriv(xn);        % f' values at nodes (for Hermite)

% Fine grid for plotting
xfine = linspace(a, b, 500);
yfine = f(xfine);

% --- Interpolants ---
% 1. Lagrange
y_lag = lagrange_interp(xn, yn, xfine);

% 2. Hermite (double nodes)
y_herm = hermite_interp(xn, yn, dn, xfine);

% 3. deBoor (cubic spline via MATLAB's spline)
cs = spline(xn, yn);
y_deboor = ppval(cs, xfine);

% 4. pchip (alternative shape-preserving spline)
y_pchip = pchip(xn, yn, xfine);

% --- Plot ---
figure('Position', [100, 100, 900, 600]);
hold on;

plot(xfine, yfine,    'k-',  'LineWidth', 2,   'DisplayName', 'f(x)');
plot(xfine, y_lag,    'b--', 'LineWidth', 1.5,  'DisplayName', 'Lagrange');
plot(xfine, y_herm,   'r-.', 'LineWidth', 1.5,  'DisplayName', 'Hermite (double nodes)');
plot(xfine, y_deboor, 'm-',  'LineWidth', 1.5,  'DisplayName', 'deBoor (cubic spline)');
plot(xfine, y_pchip,  'c-',  'LineWidth', 1.5,  'DisplayName', 'pchip');
plot(xn, yn, 'ko', 'MarkerFaceColor', 'k', 'MarkerSize', 7, 'DisplayName', 'Nodes');

hold off;
xlabel('x');
ylabel('y');
title('Lab 9 – Cubic Spline, Lagrange, Hermite and deBoor Interpolation');
legend('Location', 'best');
grid on;
ylim([-1.5, 2]);

%[appendix]{"version":"1.0"}
%---
%[metadata:view]
%   data: {"layout":"onright"}
%---
