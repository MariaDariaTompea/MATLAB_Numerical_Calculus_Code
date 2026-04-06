function D = divided_diff_table_double(x, f, df)
% Divided differences table for DOUBLE nodes
% x  - original nodes (without repetition), e.g. [0,1,2]
% f  - function values f(xi)
% df - derivative values f'(xi)
%
% f(x)  = 1/(1+x)  =>  f'(x) = -1/(1+x)^2

    n = length(x);
    N = 2*n;  % total number of nodes (each doubled)

    % Build expanded node vector: [x0,x0, x1,x1, x2,x2, ...]
    t = zeros(1, N);
    for i = 1:n
        t(2*i-1) = x(i);
        t(2*i)   = x(i);
    end

    % Initialize D with zeros
    D = zeros(N, N);

    % Order 0: fill f values
    for i = 1:n
        D(2*i-1, 1) = f(i);   % f(xi)
        D(2*i,   1) = f(i);   % f(xi) again (double node)
    end

    % Order 1: for equal consecutive nodes use derivative
    for i = 1:N-1
        if t(i+1) == t(i)
            % A(i,2) = f'(xi)
            D(i, 2) = df(ceil(i/2));
        else
            D(i, 2) = (D(i+1,1) - D(i,1)) / (t(i+1) - t(i));
        end
    end

    % Orders 2 to N-1: standard formula
    for j = 3:N
        for i = 1:(N - j + 1)
            if t(i + j - 1) == t(i)
                % Coincident nodes: use derivative (only for j=2, handled above)
                % Higher orders with coincident nodes don't appear here for double nodes
                D(i, j) = 0;
            else
                D(i, j) = (D(i+1, j-1) - D(i, j-1)) / (t(i+j-1) - t(i));
            end
        end
    end

    % --- Pretty print ---
    fprintf('\n===== Divided Differences Table (DOUBLE nodes) =====\n');
    fprintf('%-10s %-14s', 't', 'f[t] (ord.0)');
    for k = 1:N-1
        fprintf('Order %-6d', k);
    end
    fprintf('\n%s\n', repmat('-', 1, 10 + 14 + 12*(N-1)));

    for i = 1:N
        fprintf('%-10.4f ', t(i));
        for j = 1:(N - i + 1)
            fprintf('%-14.8f ', D(i, j));
        end
        fprintf('\n');
    end

    fprintf('\nNewton coefficients (first row):\n');
    for j = 1:N
        fprintf('  a%d = %.8f\n', j-1, D(1,j));
    end
end