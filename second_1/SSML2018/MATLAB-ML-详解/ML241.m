clear all
n=50;   N=1000;
x=linspace(-3,3,n)';    X=linspace(-3,3,N)';
pix=pi*x;
y=sin(pix)./(pix)+0.1*x+0.05*randn(n,1);
 
p(:,1)=ones(n,1);   P(:,1)=ones(N,1);
for j=1:4
    p(:,2*j)=sin(j/2*x);    p(:,2*j+1)=cos(j/2*x);
    P(:,2*j)=sin(j/2*X);    P(:,2*j+1)=cos(j/2*X);
end
t=p\y;
F=P*t;
 
figure(1);clf;hold on; axis([-2.8,2.8,-0.5,1.2]);
plot(X,F,'r-');plot(x,y,'bo');
 
e=p\y-inv(p'*p)*p'*y;
ME=sum(abs(e)/n);
disp('mean of absolute errors = '); disp(ME)
