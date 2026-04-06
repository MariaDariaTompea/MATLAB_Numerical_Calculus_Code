clc; clear; close all;

% function
f = @(x) (x + 1) ./ (3*x.^2 + 2*x + 1);

% nodes
x_nodes = linspace(-2, 4, 10);
y_nodes = f(x_nodes);

% dense grid
x_plot = linspace(-2, 4, 400);
f_values = f(x_plot);

% Lagrange polynomial
lagrange_values = zeros(size(x_plot));

for k = 1:length(x_plot)
    x = x_plot(k);
    L = 0;
    n = length(x_nodes);

    for i = 1:n
        term = y_nodes(i);
        for j = 1:n
            if i ~= j
                term = term * (x - x_nodes(j)) / (x_nodes(i) - x_nodes(j));
            end
        end
        L = L + term;
    end

    lagrange_values(k) = L;
end

% Plot
figure;
plot(x_plot, f_values, 'b', 'LineWidth', 2); hold on;
plot(x_plot, lagrange_values, 'r--', 'LineWidth', 2);
scatter(x_nodes, y_nodes, 50, 'filled');
legend('f(x)', 'Lagrange', 'Nodes');
title('Lagrange Interpolation');
grid on;

% Error
error = abs(f_values - lagrange_values);
fprintf('Maximum error on [-2,4]: %f\n', max(error));

% Approximation at x = 1/2
x_test = 0.5;
L_test = 0;

for i = 1:length(x_nodes)
    term = y_nodes(i);
    for j = 1:length(x_nodes)
        if i ~= j
            term = term * (x_test - x_nodes(j)) / (x_nodes(i) - x_nodes(j));
        end
    end
    L_test = L_test + term;
end

fprintf('Approx at x=0.5: %f\n', L_test);
fprintf('Exact value: %f\n', f(x_test));
fprintf('Error: %f\n', abs(L_test - f(x_test)));