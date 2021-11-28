%polyfit可以对数据进行拟合（自定义用几次多项式），返回相应的参数，
%polyval可以生成拟合后的数据点，
%下面的例子中我们对抛物线y=3x2+6x+5进行拟合

x = -5:0.1:5;
y = 3*x.^2+6*x + 5 + randn(size(x)); %在实验中还加了一个随机噪声
p = polyfit(x,y,2); %二次多项式拟合，p其实是对应的参数估计值
yy = polyval(p,x); %二次多项式拟合，yy为拟合数据点
error=yy-y; max_error=max(error);mean_error=mean(error);

hold on
subplot(2,1,1)
plot(x,y,'.',x,yy,'r','LineWidth',2);
subplot(2,1,2)
stem(x,error)
hold off
