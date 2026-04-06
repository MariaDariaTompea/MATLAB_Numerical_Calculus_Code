clc;
clear;

% Matrix A and vector b from the exercise
A = [2 1 -1 -2;
     4 4 1 3;
    -6 -1 10 10;
    -2 1 8 4];

b = [2;4;-5;1];

fprintf('Solving Ax=b using Gaussian elimination with partial pivoting\n\n');

x = gaussian_elimination(A,b);

fprintf('Solution x:\n');
disp(x)

fprintf('Residual ||Ax-b|| = %e\n', norm(A*x-b));


%% ================= FUNCTIONS =================

function x = gaussian_elimination(A,b)

n = length(b);

for k = 1:n-1
    
    % -------- PARTIAL PIVOTING --------
    [~,p] = max(abs(A(k:n,k)));   % find largest element in column
    p = p + k - 1;                % correct index
    
    % swap rows
    if p ~= k
        A([k p],:) = A([p k],:);
        b([k p]) = b([p k]);
    end
    
    % -------- ELIMINATION --------
    for i = k+1:n
        
        m = A(i,k)/A(k,k);
        
        A(i,k:n) = A(i,k:n) - m*A(k,k:n);
        b(i) = b(i) - m*b(k);
        
    end
    
end

% solve triangular system
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
    
    x(i) = (b(i) - s) / U(i,i);
    
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
    
    y(i) = (b(i) - s) / L(i,i);
    
end

end