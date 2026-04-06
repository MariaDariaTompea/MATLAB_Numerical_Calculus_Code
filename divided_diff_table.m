function D = divided_diff_table(x, f)
    n = length(x);
    D = zeros(n, n);
    D(:, 1) = f(:);

    for j = 2:n
        for i = 1:(n - j + 1)
            D(i, j) = (D(i+1, j-1) - D(i, j-1)) / (x(i+j-1) - x(i));
        end
    end

    fprintf('\n===== Divided Differences Table =====\n');
    fprintf('%-10s %-14s', 'x', 'ord.0');
    for k = 1:n-1
        fprintf('ord.%-10d', k);
    end
    fprintf('\n%s\n', repmat('-', 1, 10 + 14 + 14*(n-1)));
    for i = 1:n
        fprintf('%-10.4f ', x(i));
        for j = 1:(n-i+1)
            fprintf('%-14.6f ', D(i,j));
        end
        fprintf('\n');
    end
    fprintf('\nNewton coefficients:\n');
    for j = 1:n
        fprintf('  a%d = %.6f\n', j-1, D(1,j));
    end
end