clear all
n=50;   N=1000;
x=linspace(-3,3,n)';    X=linspace(-3,3,N)';
pix=pi*x;   piX=pi*X;
y=sin(pix)./(pix)+0.1*x+0.1*randn(n,1);
Y=sin(piX)./(piX)+0.1*X+0.05*randn(N,1);
 
x2=x.^2;    X2=X.^2; 
hh=2*0.3^2; 
l=0.1;
k=exp(-(repmat(x2,1,n)+repmat(x2',n,1)-2*(x*x'))/hh);
K=exp(-(repmat(X2,1,N)+repmat(X2',N,1)-2*(X*X'))/hh);
t1=k\y;
F1=k*t1;
t2=(K^2+l*eye(N))\(K*Y); 
F2=K*t2;
 
figure(1);  clf;  hold on; axis([-2.8,2.8,-0.5,1.2]);
plot(x,F1,'g-');    plot(X,F2,'r--');   plot(x,y,'bx');
legend('LS','L2-Constraineed LS');
