clear; clc; close all;

% --- Nodes ---
xn = [-1, -1/2, 0, 1/2, 1, 3/2];
yn = f2(xn);
dn = f2_deriv(xn);   % for Hermite/clamped

% Fine grid for plotting
xfine = linspace(-1, 3/2, 600);
yfine = f2(xfine);

% -------------------------------------------------------
% (a) deBoor: natural cubic spline (not-a-knot default)
% -------------------------------------------------------
cs_deboor = spline(xn, yn);
y_deboor  = ppval(cs_deboor, xfine);

% -------------------------------------------------------
% (a) Complete (clamped) cubic spline:
%     spline() accepts endpoint derivatives when yn has
%     length n+2: [d0, y1..yn, dn]
% -------------------------------------------------------
yn_clamped = [dn(1), yn, dn(end)];
cs_complete = spline(xn, yn_clamped);
y_complete  = ppval(cs_complete, xfine);

% -------------------------------------------------------
% (a) Piecewise Hermite cubic spline (pchip uses f' at nodes)
%     For "Hermite cubic spline" we use the exact derivatives.
%     MATLAB's pchip computes its own slopes; to use exact
%     derivatives we build the pp manually via spline trick:
%     pass [dn(1), yn, dn(end)] — but for ALL interior nodes
%     we need mkpp. We use a manual approach below.
% -------------------------------------------------------
cs_hermite = pchip_exact(xn, yn, dn);
y_hermite  = ppval(cs_hermite, xfine);

% -------------------------------------------------------
% (b) Plot
% -------------------------------------------------------
figure('Position', [100, 100, 900, 600]);
hold on;
plot(xfine, yfine,      'k-',  'LineWidth', 2,   'DisplayName', 'f(x) = x·sin(πx)');
plot(xfine, y_deboor,   'b--', 'LineWidth', 1.5,  'DisplayName', 'deBoor (not-a-knot)');
plot(xfine, y_complete, 'r-.', 'LineWidth', 1.5,  'DisplayName', 'Complete (clamped)');
plot(xfine, y_hermite,  'm-',  'LineWidth', 1.5,  'DisplayName', 'Piecewise Hermite');
plot(xn, yn, 'ko', 'MarkerFaceColor','k', 'MarkerSize', 8, 'DisplayName', 'Nodes');
hold off;
xlabel('x'); ylabel('y');
title('Problem 2 – Cubic Spline Interpolants of f(x) = x·sin(πx)');
legend('Location','best');
grid on;

%[appendix]{"version":"1.0"}
%---
%[metadata:view]
%   data: {"layout":"onright"}
%---
