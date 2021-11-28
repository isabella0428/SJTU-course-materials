%interp1��һά�ڲ庯����
%interp1(x,y,xi),interp1(x,y,xi,'method')�����е�x,y��ԭ��֪�� ���ݵ�x,yֵ��
%%%%%%%%%%%%%%%%%%%%%��xi����Ҫ�ڲ�����ݵ㣬
%%%%%%%%%%%%%%%%%%%%%method�����趨�ڲ巽���� linear,cubic,spline.pchip

%��֪һ����ÿһ��Сʱ���¶ȣ�������ÿ0.1

h=1:24;
temp=[5 6 8 8 9 12 15 20 25 27 29 30 31 31 30 25 22 20 19 17 15 12 10 7];
plot(h,temp,'--',h,temp,'+')

h_3=1:0.1:24; %% ÿ0.1Сʱ����һ���¶�ֵ
t_1=interp1(h,temp,h_3,'linear'); % ���Բ�ֵ
t_3=interp1(h,temp,h_3,'cubic'); %  �����η���ʽ���ڲ�
t_s=interp1(h,temp,h_3,'spline'); % ��spline�������ڲ�


hold on
subplot(1,3,1)
plot(h,temp,'--',h,temp,'+',h_3,t_1) % �����Բ�ֵ��ϻ�ͼ
subplot(1,3,2)
plot(h,temp,'--',h,temp,'+',h_3,t_3) % �����Լ����η���ʽ�ڲ��ͼ
subplot(1,3,3)
plot(h,temp,'--',h,temp,'+',h_3,t_s) % �����Է���ʽ��spline�ڲ��ͼ
hold off