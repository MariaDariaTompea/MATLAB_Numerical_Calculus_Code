clc; clear; close all;

% data
x = [1980 1990 2000 2010 2020];
y = [22.21 23.21 22.14 20.43 19.39];

n = length(x);

% compute barycentric weights
w = ones(1, n);

for j = 1:n
    for k = 1:n
        if j ~= k
            w(j) = w(j) / (x(j) - x(k));
        end
    end
end

% barycentric interpolation function
barycentric = @(x_val) ...
    sum((w ./ (x_val - x)) .* y) / sum(w ./ (x_val - x));

% approximations
val_2005 = barycentric(2005);
val_2015 = barycentric(2015);

fprintf('Estimated population in 2005: %.4f\n', val_2005);
fprintf('Estimated population in 2015: %.4f\n', val_2015);

% real values
real_2005 = 21.21;
real_2015 = 19.91;

% relative errors
err_2005 = abs(val_2005 - real_2005) / real_2005;
err_2015 = abs(val_2015 - real_2015) / real_2015;

fprintf('Relative error (2005): %.6f\n', err_2005);
fprintf('Relative error (2015): %.6f\n', err_2015);

%% ----------- PLOT -----------

x_plot = linspace(1980, 2020, 300);
y_plot = arrayfun(barycentric, x_plot);

figure;
plot(x_plot, y_plot, 'b', 'LineWidth', 2); hold on;
scatter(x, y, 80, 'filled'); % original data points
scatter([2005 2015], [val_2005 val_2015], 100, 'r', 'filled');

legend('Interpolation polynomial', 'Given data', 'Estimated points');
title('Barycentric Interpolation - Romania Population');
xlabel('Year');
ylabel('Population (million people)');
grid on;