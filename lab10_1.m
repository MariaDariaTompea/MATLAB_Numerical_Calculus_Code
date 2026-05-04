% lab10_1.m
% Approximate ln(2) = integral from 1 to 2 of 1/x dx
% Using repeated rectangle, trapezoidal, and Simpson's rules
% with enough subintervals for 3 correct decimal places

clear; clc;

a = 1; b = 2;
exact = log(2);  % exact value

fprintf('Exact value of ln(2) = %.10f\n\n', exact);

% We need 3 correct decimals => error < 5e-4
% Try increasing n until error < 5e-4 for each method

f = @(x) 1./x;

fprintf('%-10s %-20s %-20s %-20s\n', 'n', 'Rectangle', 'Trapezoid', 'Simpson');
fprintf('%s\n', repmat('-', 1, 72));

for n = [2, 4, 8, 16, 32, 64, 128]
    h = (b - a) / n;
    xi = a:h:b;

    % Midpoint (rectangle) rule
    xm = a + h/2 : h : b - h/2;
    Irect = h * sum(f(xm));

    % Trapezoidal rule
    Itrap = h * (f(a)/2 + sum(f(xi(2:end-1))) + f(b)/2);

    % Simpson's rule (requires even n)
    if mod(n, 2) == 0
        w = ones(1, n+1);
        w(2:2:end-1) = 4;
        w(3:2:end-2) = 2;
        Isimp = (h/3) * sum(w .* f(xi));
    else
        Isimp = NaN;
    end

    fprintf('n=%-8d Rect: %.8f (err=%.2e)  Trap: %.8f (err=%.2e)  Simp: %.8f (err=%.2e)\n', ...
        n, Irect, abs(Irect - exact), Itrap, abs(Itrap - exact), Isimp, abs(Isimp - exact));
end

fprintf('\n--- Selecting n for 3 correct decimal places (error < 5e-4) ---\n');

for n = 1:200
    h = (b - a) / n;
    xi = a:h:b;
    xm = a + h/2 : h : b - h/2;

    Irect = h * sum(f(xm));
    Itrap = h * (f(a)/2 + sum(f(xi(2:end-1))) + f(b)/2);

    if mod(n, 2) == 0
        w = ones(1, n+1);
        w(2:2:end-1) = 4;
        w(3:2:end-2) = 2;
        Isimp = (h/3) * sum(w .* f(xi));
    else
        Isimp = Inf;
    end

    if abs(Irect - exact) < 5e-4
        fprintf('Rectangle rule: n = %d gives error = %.2e\n', n, abs(Irect - exact));
        break;
    end
end

for n = 1:200
    h = (b - a) / n;
    xi = a:h:b;
    Itrap = h * (f(a)/2 + sum(f(xi(2:end-1))) + f(b)/2);
    if abs(Itrap - exact) < 5e-4
        fprintf('Trapezoidal rule: n = %d gives error = %.2e\n', n, abs(Itrap - exact));
        break;
    end
end

for n = 2:2:200
    h = (b - a) / n;
    xi = a:h:b;
    w = ones(1, n+1);
    w(2:2:end-1) = 4;
    w(3:2:end-2) = 2;
    Isimp = (h/3) * sum(w .* f(xi));
    if abs(Isimp - exact) < 5e-4
        fprintf('Simpson rule:     n = %d gives error = %.2e\n', n, abs(Isimp - exact));
        break;
    end
end