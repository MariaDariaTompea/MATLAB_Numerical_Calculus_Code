clear; clc; close all;

% --- Data ---
T = [0, 10, 20, 30, 40, 60, 80, 100];
P = [0.0061, 0.0123, 0.0234, 0.0424, 0.0738, 0.1992, 0.4736, 1.0133];

% -------------------------------------------------------
% (a) Quadratic (degree 2) least squares fit
% -------------------------------------------------------
p2 = polyfit(T, P, 2);
fprintf('Quadratic polynomial coefficients:\n');
fprintf('  p(T) = %.8f·T^2 %+.8f·T %+.8f\n', p2(1), p2(2), p2(3));

% Quadratic error
P_approx2  = polyval(p2, T);
res2       = P - P_approx2;
SSE2       = sum(res2.^2);
RMS2       = sqrt(SSE2 / length(T));
fprintf('Quadratic  -> SSE = %.8f,  RMS = %.8f\n', SSE2, RMS2);

% -------------------------------------------------------
% (a) Cubic (degree 3) least squares fit
% -------------------------------------------------------
p3 = polyfit(T, P, 3);
fprintf('\nCubic polynomial coefficients:\n');
fprintf('  p(T) = %.8f·T^3 %+.8f·T^2 %+.8f·T %+.8f\n', p3(1),p3(2),p3(3),p3(4));

% Cubic error
P_approx3  = polyval(p3, T);
res3       = P - P_approx3;
SSE3       = sum(res3.^2);
RMS3       = sqrt(SSE3 / length(T));
fprintf('Cubic      -> SSE = %.8f,  RMS = %.8f\n', SSE3, RMS3);

% Which is better?
fprintf('\n--- Which approximation is better? ---\n');
if RMS3 < RMS2
    fprintf('Cubic is better (lower RMS: %.6f < %.6f)\n', RMS3, RMS2);
else
    fprintf('Quadratic is better (lower RMS: %.6f < %.6f)\n', RMS2, RMS3);
end

% -------------------------------------------------------
% (b) Estimate pressure at T = 45
% -------------------------------------------------------
T_est = 45;
P_quad = polyval(p2, T_est);
P_cub  = polyval(p3, T_est);
fprintf('\n--- Estimate at T = 45°C ---\n');
fprintf('Quadratic approximation: P(45) = %.6f bar\n', P_quad);
fprintf('Cubic     approximation: P(45) = %.6f bar\n', P_cub);

% -------------------------------------------------------
% (c) Plot data and both approximating polynomials
% -------------------------------------------------------
Tfine = linspace(-2, 105, 500);
P2fine = polyval(p2, Tfine);
P3fine = polyval(p3, Tfine);

figure('Position', [100, 100, 900, 550]);
hold on;
scatter(T, P, 100, 'ko', 'filled', 'DisplayName', 'Data (T, P)');
plot(Tfine, P2fine, 'b-',  'LineWidth', 2, 'DisplayName', 'Quadratic least squares');
plot(Tfine, P3fine, 'r--', 'LineWidth', 2, 'DisplayName', 'Cubic least squares');
plot(T_est, P_quad, 'b^', 'MarkerSize', 10, 'LineWidth', 1.5, ...
     'DisplayName', sprintf('Quad at T=45: %.4f bar', P_quad));
plot(T_est, P_cub,  'rv', 'MarkerSize', 10, 'LineWidth', 1.5, ...
     'DisplayName', sprintf('Cubic at T=45: %.4f bar', P_cub));
hold off;

xlabel('Temperature T (°C)');
ylabel('Pressure P (bar)');
title('Problem 4 – Water Vapour Pressure: Least Squares Polynomial Approximation');
legend('Location', 'northwest');
grid on;

%[appendix]{"version":"1.0"}
%---
%[metadata:view]
%   data: {"layout":"onright"}
%---
