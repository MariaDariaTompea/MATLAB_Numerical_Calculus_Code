clc;
clear;

% Define matrix A and vector b
A = [2 1 -1 -2;
     4 4 1 3;
    -6 -1 10 10;
    -2 1 8 4];

b = [2;4;-5;1];

fprintf('===== Comparison of Linear System Solvers =====\n\n');

%% Gaussian Elimination with Partial Pivoting
tic
x_gauss = gaussian_elimination(A,b);
t_gauss = toc;

res_gauss = norm(A*x_gauss - b);

fprintf('--- Gaussian Elimination ---\n');
disp('Solution:')
disp(x_gauss)
fprintf('Residual error: %e\n',res_gauss);
fprintf('Time: %f seconds\n\n',t_gauss);

%% LUP Factorization
tic
x_lup = solve_LUP(A,b);
t_lup = toc;

res_lup = norm(A*x_lup - b);

fprintf('--- LUP Factorization ---\n');
disp('Solution:')
disp(x_lup)
fprintf('Residual error: %e\n',res_lup);
fprintf('Time: %f seconds\n\n',t_lup);

%% QR Factorization
tic
x_qr = solve_QR(A,b);
t_qr = toc;

res_qr = norm(A*x_qr - b);

fprintf('--- QR Factorization ---\n');
disp('Solution:')
disp(x_qr)
fprintf('Residual error: %e\n',res_qr);
fprintf('Time: %f seconds\n\n',t_qr);

%% Summary
fprintf('===== Summary =====\n');
fprintf('Method\t\tResidual\t\tTime\n');
fprintf('Gaussian\t%e\t%f\n',res_gauss,t_gauss);
fprintf('LUP\t\t%e\t%f\n',res_lup,t_lup);
fprintf('QR\t\t%e\t%f\n',res_qr,t_qr);


%% ================= FUNCTIONS =================

function x = gaussian_elimination(A,b)

n = length(b);

for k = 1:n-1
    
    % Partial pivoting
    [~,m] = max(abs(A(k:n,k)));
    m = m + k - 1;
    
    % Swap rows
    A([k m],:) = A([m k],:);
    b([k m]) = b([m k]);
    
    % Elimination
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
    
    x(i) = (b(i) - s)/U(i,i);
    
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
    
    y(i) = (b(i) - s)/L(i,i);
    
end

end


function x = solve_LUP(A,b)

[L,U,P] = lu(A);

y = forwardsub(L, P*b);

x = backsub(U, y);

end


function x = solve_QR(A,b)

[Q,R] = qr(A);

x = backsub(R, Q'*b);

end


function x = solve_cholesky(A,b)

L = chol(A,'lower');

y = forwardsub(L,b);

x = backsub(L',y);

end