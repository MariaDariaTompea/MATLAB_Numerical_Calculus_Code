clear all
clc
pause(1)
% Prompt for distribution model
option = input("Enter the distribution model (N for Normal, S for Student, C for Chi2, F for Fisher):", 's');

switch option
    case 'N'
        fprintf("Normal model\n");
        mu = input("mu = ");
        sigma = input("sigma = ");
        
        % Part (a)
        fprintf("a1) P(X <= 0) = %f\n", normcdf(0, mu, sigma));
        fprintf("a2) P(X >= 0) = %f\n", 1 - normcdf(0, mu, sigma));
        
        % Part (b)
        fprintf("b1) P(-1 <= X <= 1) = %f\n", normcdf(1, mu, sigma) - normcdf(-1, mu, sigma));
        fprintf("b2) P(X <= -1 or X >= 1) = %f\n", 1 - (normcdf(1, mu, sigma) - normcdf(-1, mu, sigma)));
        
        % Part (c)
        alpha = input("Enter the value of alpha for quantile computation: ");
        x_alpha = norminv(alpha, mu, sigma);
        fprintf("c) x_alpha such that P(X <= x_alpha) = %f is %f\n", alpha, x_alpha);

        % Part (d)
        beta = input("Enter the value of beta for quantile computation: ");
        x_beta = norminv(1 - beta, mu, sigma);
        fprintf("d) x_beta such that P(X > x_beta) = %f is %f\n", beta, x_beta);

        
    case 'S'
        fprintf("Student model\n");
        n = input("Degrees of freedom (n) = ");
        
        % Part (a)
        fprintf("a1) P(X <= 0) = %f\n", tcdf(0, n));
        fprintf("a2) P(X >= 0) = %f\n", 1 - tcdf(0, n));
        
        % Part (b)
        fprintf("b1) P(-1 <= X <= 1) = %f\n", tcdf(1, n) - tcdf(-1, n));
        fprintf("b2) P(X <= -1 or X >= 1) = %f\n", 1 - (tcdf(1, n) - tcdf(-1, n)));
        
        % Part (c)
        alpha = input("Enter the value of alpha for quantile computation: ");
        x_alpha = tinv(alpha, n);
        fprintf("c) x_alpha such that P(X <= x_alpha) = %f is %f\n", alpha, x_alpha);
        
    case 'C'
        fprintf("Chi2 model\n");
        n = input("Degrees of freedom (n) = ");
        
        % Part (a)
        fprintf("a1) P(X <= 0) = %f\n", chi2cdf(0, n));  
        fprintf("a2) P(X >= 0) = %f\n", 1 - chi2cdf(0, n));  % Should be 1 for chi-square
        
        % Part (b)
        fprintf("b1) P(-1 <= X <= 1) = %f\n", chi2cdf(1, n) - chi2cdf(-1, n)); 
        fprintf("b2) P(X <= -1 or X >= 1) = %f\n", 1 - (chi2cdf(1, n) - chi2cdf(-1, n)));  
        
        % Part (c)
        alpha = input("Enter the value of alpha for quantile computation: ");
        x_alpha = chi2inv(alpha, n);
        fprintf("c) x_alpha such that P(X <= x_alpha) = %f is %f\n", alpha, x_alpha);
        
    case 'F'
        fprintf("Fisher model\n");
        m = input("Degrees of freedom (m) for numerator = ");
        n = input("Degrees of freedom (n) for denominator = ");
        
        % Part (a)
        fprintf("a1) P(X <= 0) = %f\n", fcdf(0, m, n));  % Note: For F-distribution, P(X <= 0) is zero
        fprintf("a2) P(X >= 0) = %f\n", 1 - fcdf(0, m, n));  % Should be 1 for F-distribution
        
        % Part (b)
        fprintf("b1) P(-1 <= X <= 1) = %f\n", fcdf(1, m, n) - fcdf(-1, m, n));  % Not meaningful for F-distribution (X >= 0)
        fprintf("b2) P(X <= -1 or X >= 1) = %f\n", 1 - (fcdf(1, m, n) - fcdf(-1, m, n)));  % Also not meaningful for F-distribution
        
        % Part (c)
        alpha = input("Enter the value of alpha for quantile computation: ");
        x_alpha = finv(alpha, m, n);
        fprintf("c) x_alpha such that P(X <= x_alpha) = %f is %f\n", alpha, x_alpha);
        
    otherwise
        fprintf("Wrong option!\n");
end
