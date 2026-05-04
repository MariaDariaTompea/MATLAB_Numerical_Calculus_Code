%TEST 3
%Nickel poweders are used in coating used to shield electronic uquipment. 
%Random sample is selected of the sizes of nickel particles in each coating
%Values recorded [..................]
%A) find a 95% confidence interval for the average size of nickel particles
%B) at 1% significance level on average do these nickel particles seem to
%be smaller than 3
%you shall find the answers to the questions at the end of the test
clear all;
clc;
pause(0.5);

% Given data: Nickel particle sizes (nck) in a sample.
nck = [3.26, 1.89, 2.42, 2.03, 3.07, 2.95, 1.39, 3.06, 2.46, 3.35, 1.56, 1.79, 1.76, 3.82, 2.42, 2.96];

% a) Calculate a 95% confidence interval for the mean size of nickel
% particles
alpha1 = 0.05; % Significance level for confidence interval
n = length(nck); % Sample size
meanNck = mean(nck); % Sample mean
s = std(nck); % Sample standard deviation

% Formula to compute confidence interval
theta_lower = meanNck - (s/sqrt(n)) * tinv(1-alpha1/2, n-1); % Lower bound
theta_upper = meanNck + (s/sqrt(n)) * tinv(1-alpha1/2, n-1); % Upper bound

% Display the confidence interval
fprintf("The 95%% Confidence Interval is: (%.3f, %.3f)\n", theta_lower, theta_upper);

% Hypothesis Test:
% Null Hypothesis (H0): The mean size of nickel particles is 3 (Theta = 3).
% Alternate Hypothesis (H1): The mean size of nickel particles is less than
% 3 (Theta < 3).

alpha2 = 0.01; % Significance level for hypothesis test
[H, P, CI, ZVAL] = ttest(nck, 3, 'Alpha', alpha2, 'Tail', 'left'); % One-sample t-test
TS0 = ZVAL.tstat; % Test statistic (t-value)

% Display statistical results
fprintf("Test Statistic (TS0): %.3f\n", TS0); % t-statistic value
fprintf("p-value (P): %.5f\n", P); % p-value of the test

% Decision based on hypothesis test
% If H == 1, we reject the null hypothesis in favor of the alternate 
% hypothesis.
if H == 1
    fprintf("H0 rejected => Nickel particles seem to be smaller than 3\n");
else
    fprintf("H0 is not rejected => Nickel particles do not seem to be smaller than 3\n");
end


% Null Hypothesis (H0): This assumes that the mean size of nickel particles
% is equal to 3. 
% This case => H0: Theta = 3.

% Alternate Hypothesis (H1): This assumes that the mean size of nickel
% particles
% %is less than 3.
% In this case: H1: Theta < 3.

% Statistical Answer of the Question:
% The statistical answer depends on the results of the hypothesis test. 
% If the null hyphothesis (H0) is rejected then it means that there is 
% sufficient evidence to support the claim
% that the mean size of nickel particles is smaller than 3. If H0 is not
% rejected, it means there is insufficient
% evidence to support this.

% Real Answer of the Question:
% The real answer interprets the statistical results in practical terms. 
% If H0 is rejected we conclude that the nickel particles' mean size 
% is statistically smaller than 3. 
% Otherwise the data does not provide enough evidence to conclude 
% that the mean size is smaller than 3.

% PR (Rejection Probability): PR is the significance level (alpha2) of the
% hyphothesis test.
% It represents the probability of rejecting the null hypothesis when it is
% actually true.
% In this case, PR = 0.01 => there is a 1% chance of incorrectly rejecting 
% H0.

% P (p-value): The p-value is the probability of observing a test statistic
% at least as extreme as the one 
% calculated, assuming that the null hyphothesis is true. A smaller p-value 
% indicates stronger evidence
% against H0. If P < PR we reject H0.

% TS0 (Test Statistic): The test statistic is a measure of how far the sample mean is from the hypothesized
% mean Theta = 3 in units of standard error. It is used to determine whether the observed data 
% is consistent with the null hypothesis. A more negative TS0 indicates stronger evidence against H0.






























% :(