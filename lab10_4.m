% lab10_4.m
% Arc length of f(x) = sin(pi*x) on [0,1]
% l(f) = integral from 0 to 1 of sqrt(1 + [f'(x)]^2) dx
% Using adaptive Simpson's quadrature

clear; clc;

a = 0; b = 1;
f  = @(x) sin(pi * x);
df = @(x) pi * cos(pi * x);
g  = @(x) sqrt(1 + df(x).^2);   % integrand for arc length

%% Part a: Plot f(x)
figure;
xx = linspace(a, b, 500);
plot(xx, f(xx), 'b-', 'LineWidth', 2);
xlabel('x'); ylabel('f(x)');
title('f(x) = sin(\pi x) on [0, 1]');
grid on;

%% Part b: Adaptive Simpson quadrature
tol = 1e-8;
[arc_length, n_evals] = adaptive_simpson(g, a, b, tol);

% Reference via built-in integral
arc_ref = integral(g, a, b, 'AbsTol', 1e-12);

fprintf('Arc length of f(x) = sin(pi*x) on [0,1]\n');
fprintf('------------------------------------------\n');
fprintf('Adaptive Simpson result : %.12f\n', arc_length);
fprintf('MATLAB integral() result: %.12f\n', arc_ref);
fprintf('Error vs integral()     : %.3e\n', abs(arc_length - arc_ref));
fprintf('Function evaluations    : %d\n', n_evals);


%% --- Adaptive Simpson functions ---
function [I, evals] = adaptive_simpson(f, a, b, tol)
    evals = 0;
    function I = recurse(a, b, tol, fa, fm, fb)
        m   = (a + b) / 2;
        lm  = (a + m) / 2;
        rm  = (m + b) / 2;
        flm = f(lm);  frm = f(rm);
        evals = evals + 2;

        S1 = (b - a) / 6  * (fa + 4*fm + fb);
        S2 = (b - a) / 12 * (fa + 4*flm + 2*fm + 4*frm + fb);

        if abs(S2 - S1) < 15 * tol
            I = S2 + (S2 - S1) / 15;
        else
            IL = recurse(a, m, tol/2, fa, flm, fm);
            IR = recurse(m, b, tol/2, fm, frm, fb);
            I  = IL + IR;
        end
    end

    fa = f(a); fm = f((a+b)/2); fb = f(b);
    evals = 3;
    I = recurse(a, b, tol, fa, fm, fb);
end