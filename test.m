clear all
clc
pause(1);
p=input("prob of succes (0.05<=p<=0.95)=");
while p<0.05 | p>0.95
p=input("prob of succes (0.05<=p<=0.95)=");
end

for n=1:10
    x=0:n; %x gets values from 0 to n
    px=binopdf(x,n,p);
    plot(x,px,'o');
    hold on;
    mu=n*p;
    sigma=sqrt(n*p*(1-p));
    xreal=0:0.01:n;

    normpx=normpdf(xreal,mu,sigma);
    plot(xreal,normpx);
    hold off;
    legend("bino","norm");
    title("Approx. of bino with norm. (n="+n+")");
    pause(0.5);
end