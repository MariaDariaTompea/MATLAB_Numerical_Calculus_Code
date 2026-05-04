clear; clc; close all;

% --- Data ---
xdata = [0.5, 1.5, 2, 3, 3.5, 4.5, 5, 6, 7, 8];
fdata = [5,   5.8, 5.8, 6.8, 6.9, 7.6, 7.8, 8.2, 9.2, 9.9];

% -------------------------------------------------------
% (a) Scatterplot + least squares polynomial (degree 1,2,3)
%     We use polyfit and pick the best degree visually.
%     Lab context: try degree 1 (linear) first, then degree 2.
% -------------------------------------------------------
deg = 2;   % change to 1 or 3 to compare
p = polyfit(xdata, fdata, deg);

fprintf('Least squares polynomial (degree %d):\n', deg);
fprintf('Coefficients: '); disp(p);

% -------------------------------------------------------
% (b) Error: sum of squared residuals and RMS error
% -------------------------------------------------------
f_approx_nodes = polyval(p, xdata);
residuals = fdata - f_approx_nodes;
SSE = sum(residuals.^2);
RMS = sqrt(SSE / length(xdata));
fprintf('Sum of squared errors (SSE): %.6f\n', SSE);
fprintf('RMS error:                   %.6f\n', RMS);

% -------------------------------------------------------
% (c) Estimate at x = 4
% -------------------------------------------------------
val_at_4 = polyval(p, 4);
fprintf('Estimated f(4) = %.6f\n', val_at_4);

% -------------------------------------------------------
% (d) Plot data and approximation polynomial
% -------------------------------------------------------
xfine = linspace(min(xdata)-0.5, max(xdata)+0.5, 400);
yfine = polyval(p, xfine);

figure('Position', [100, 100, 900, 500]);
hold on;
scatter(xdata, fdata, 80, 'ko', 'filled', 'DisplayName', 'Data points');
plot(xfine, yfine, 'b-', 'LineWidth', 2, ...
     'DisplayName', sprintf('Least squares poly (deg %d)', deg));
plot(4, val_at_4, 'r*', 'MarkerSize', 14, 'LineWidth', 2, ...
     'DisplayName', sprintf('Estimate at x=4: %.4f', val_at_4));
hold off;
xlabel('x'); ylabel('f');
title(sprintf('Problem 3 – Least Squares Polynomial Approximation (degree %d)', deg));
legend('Location','best');
grid on;

% Print polynomial string
fprintf('\nPolynomial: ');
for k = 1:length(p)
    pw = deg - k + 1;
    if pw > 1
        fprintf('%+.4f·x^%d ', p(k), pw);
    elseif pw == 1
        fprintf('%+.4f·x ', p(k));
    else
        fprintf('%+.4f', p(k));
    end
end
fprintf('\n');

%[appendix]{"version":"1.0"}
%---
%[metadata:view]
%   data: {"layout":"onright"}
%---
