function d = numerical_deriv(xn)
    % Compute f'(x) analytically for f(x) = (x+1)/(3x^2+2x+1)
    % f'(x) = [(3x^2+2x+1) - (x+1)(6x+2)] / (3x^2+2x+1)^2
    num = (3*xn.^2 + 2*xn + 1) - (xn + 1).*(6*xn + 2);
    den = (3*xn.^2 + 2*xn + 1).^2;
    d = num ./ den;
end

%[appendix]{"version":"1.0"}
%---
