%interp1是一维内插函数，
%interp1(x,y,xi),interp1(x,y,xi,'method')；其中的x,y是原已知的 数据的x,y值，
%%%%%%%%%%%%%%%%%%%%%而xi则是要内插的数据点，
%%%%%%%%%%%%%%%%%%%%%method可以设定内插方法有 linear,cubic,spline.pchip

%已知一天内每一个小时的温度，求推算每0.1

h=1:24;
temp=[5 6 8 8 9 12 15 20 25 27 29 30 31 31 30 25 22 20 19 17 15 12 10 7];
plot(h,temp,'--',h,temp,'+')

h_3=1:0.1:24; %% 每0.1小时估计一次温度值
t_1=interp1(h,temp,h_3,'linear'); % 线性插值
t_3=interp1(h,temp,h_3,'cubic'); %  以三次方程式做内插
t_s=interp1(h,temp,h_3,'spline'); % 以spline函数做内插


hold on
subplot(1,3,1)
plot(h,temp,'--',h,temp,'+',h_3,t_1) % 将线性插值拟合绘图
subplot(1,3,2)
plot(h,temp,'--',h,temp,'+',h_3,t_3) % 将线性及三次方程式内插绘图
subplot(1,3,3)
plot(h,temp,'--',h,temp,'+',h_3,t_s) % 将线性方程式及spline内插绘图
hold off