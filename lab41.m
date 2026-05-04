clear all
clc
pause(1)
%RND command to use any model [abreviation of mode] rnd
%(where to compute usually but now ,parameters of the model,
%parameters for normal but now its the size of the matrix)
%unifrnd(0,1,2,3)
%unifrnd(-1,1,2,3)
%binornd(3,0.5,2,3)



%Let U liniarly distributed (- U(0,1). U-rand
%n=3; p=0.5 U=rand(n,S)=12

%whats the cdf of 0 for Bermudi model= <=0 adica =0 1-p
%cdf of 1 in Bern model 1=at most 1 means =>1
%Let U(- U(0,1)
%continuous U define cdf


%Fu(k) defined as (( 0 ,if k<0
%                 (( k, if k is between 0 and 1
%                 (( 1 if k>=1

%BERMUDI DISTRIBUTION
S=input("number of simulations=");
p=input("probability of succes=");

U=rand(1,S)
X=U<p;

%try for 5 simulations with probability 0.5
U_X=unique(X);%vector U

n_X=hist(X,length(U_X));
rel_freq=n_X/S;
%[U_X;n_X]
[U_X ; rel_freq] % percentage time of winning in a list of games (0,1) statistically