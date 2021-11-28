clear all
n=50;   N=1000;
x=linspace(-3,3,n)';    X=linspace(-3,3,N)';
pix=pi*x;
y=log(pix)./(pix)+0.1*x+0.05*randn(n,1);
 
p(:,1)=ones(n,1);   P(:,1)=ones(N,1);
for j=1:10
    p(:,j)=x.^j;     P(:,j)=X.^j;   
end
t=p\y;
F=P*t;
 
figure(1);clf;hold on; axis([-2.8,2.8,-1.5,1.5]);
plot(X,F,'r-');plot(x,y,'bo');

