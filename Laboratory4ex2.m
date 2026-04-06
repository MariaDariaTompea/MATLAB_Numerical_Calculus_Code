clc;
clear;

% Read system size
n = input('Enter system size n (>=3): ');

if n < 3
    error('n must be at least 3');
end

% Build matrix A
A = zeros(n,n);

for i = 1:n
    A(i,i) = 5;
end

for i = 1:n-1
    A(i,i+1) = -1;
    A(i+1,i) = -1;
end

% Build vector b
b = 3*ones(n,1);
b(1) = 4;
b(n) = 4;

fprintf('\nMatrix A:\n');
disp(A)

fprintf('Vector b:\n');
disp(b)

fprintf('\n===== Solving the system =====\n\n');

%% Gaussian Elimination
tic
x_gauss = gaussian_elimination(A,b);
t_gauss = toc;

fprintf('--- Gaussian Elimination ---\n');
disp(x_gauss)
fprintf('Residual: %e\n\n',norm(A*x_gauss-b));

%% LUP Factorization
tic
x_lup = solve_LUP(A,b);
t_lup = toc;

fprintf('--- LUP Factorization ---\n');
disp(x_lup)
fprintf('Residual: %e\n\n',norm(A*x_lup-b));

%% QR Factorization
tic
x_qr = solve_QR(A,b);
t_qr = toc;

fprintf('--- QR Factorization ---\n');
disp(x_qr)
fprintf('Residual: %e\n\n',norm(A*x_qr-b));

%% Summary
fprintf('===== Time Comparison =====\n');
fprintf('Gaussian: %f\n',t_gauss);
fprintf('LUP: %f\n',t_lup);
fprintf('QR: %f\n',t_qr);


%% ================= FUNCTIONS =================

function x = gaussian_elimination(A,b)

n = length(b);

for k = 1:n-1
    
    % Partial pivoting
    [~,m] = max(abs(A(k:n,k)));
    m = m + k - 1;
    
    A([k m],:) = A([m k],:);
    b([k m]) = b([m k]);
    
    for i = k+1:n
        
        factor = A(i,k)/A(k,k);
        A(i,k:n) = A(i,k:n) - factor*A(k,k:n);
        b(i) = b(i) - factor*b(k);
        
    end
end

x = backsub(A,b);

end


function x = backsub(U,b)

n = length(b);
x = zeros(n,1);

for i = n:-1:1
    
    s = 0;
    
    for j = i+1:n
        s = s + U(i,j)*x(j);
    end
    
    x(i) = (b(i)-s)/U(i,i);
    
end

end


function y = forwardsub(L,b)

n = length(b);
y = zeros(n,1);

for i = 1:n
    
    s = 0;
    
    for j = 1:i-1
        s = s + L(i,j)*y(j);
    end
    
    y(i) = (b(i)-s)/L(i,i);
    
end

end


function x = solve_LUP(A,b)

[L,U,P] = lu(A);

y = forwardsub(L,P*b);
x = backsub(U,y);

end


function x = solve_QR(A,b)

[Q,R] = qr(A);

x = backsub(R,Q'*b);

end