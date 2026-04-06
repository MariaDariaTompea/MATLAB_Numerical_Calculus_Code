function [FWRD, BKWD] = finite_diff_tables(f)
% Computes forward and backward finite difference tables
% f - vector of function values at equidistant nodes

    n = length(f);

    % ---- FORWARD differences ----
    FWRD = zeros(n, n);
    FWRD(:, 1) = f(:);
    for j = 2:n
        for i = 1:(n-j+1)
            FWRD(i, j) = FWRD(i+1, j-1) - FWRD(i, j-1);
        end
    end

    fprintf('\n===== Forward Differences Table =====\n');
    fprintf('%-10s %-12s', 'f', 'Delta^1');
    for k = 2:n-1
        fprintf('Delta^%-6d', k);
    end
    fprintf('\n%s\n', repmat('-', 1, 10 + 12 + 12*(n-2)));
    for i = 1:n
        for j = 1:(n-i+1)
            fprintf('%-12.4f ', FWRD(i,j));
        end
        fprintf('\n');
    end

    % ---- BACKWARD differences ----
    BKWD = zeros(n, n);
    BKWD(:, 1) = f(:);
    for j = 2:n
        for i = j:n
            BKWD(i, j) = BKWD(i, j-1) - BKWD(i-1, j-1);
        end
    end

    fprintf('\n===== Backward Differences Table =====\n');
    fprintf('%-10s %-12s', 'f', 'nabla^1');
    for k = 2:n-1
        fprintf('nabla^%-6d', k);
    end
    fprintf('\n%s\n', repmat('-', 1, 10 + 12 + 12*(n-2)));
    for i = 1:n
        fprintf('%-12.4f ', BKWD(i,1));
        for j = 2:i
            fprintf('%-12.4f ', BKWD(i,j));
        end
        fprintf('\n');
    end
end