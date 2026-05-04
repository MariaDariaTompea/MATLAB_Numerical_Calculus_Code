clear all
clc
pause(1)

S=input("Nr of sims= ");
n=input("Nr of trials= ");
p=input("Probability= ");

U=rand(n,S);
X=sum(U<p);


U_X=unique(X);
n_X=hist(X,length(U_X));
rel_freq= n_X/S;

plot(U_X,rel_freq,'x');
hold on;
plot(0:n,binopdf(0:n,n,p),'o');
hold off;
title("BINO MODEL");
legends("simulation","theoretical");
