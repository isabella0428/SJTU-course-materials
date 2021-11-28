%polyfit���Զ����ݽ�����ϣ��Զ����ü��ζ���ʽ����������Ӧ�Ĳ�����
%polyval����������Ϻ�����ݵ㣬
%��������������Ƕ�������y=3x2+6x+5�������

x = -5:0.1:5;
y = 3*x.^2+6*x + 5 + randn(size(x)); %��ʵ���л�����һ���������
p = polyfit(x,y,2); %���ζ���ʽ��ϣ�p��ʵ�Ƕ�Ӧ�Ĳ�������ֵ
yy = polyval(p,x); %���ζ���ʽ��ϣ�yyΪ������ݵ�
error=yy-y; max_error=max(error);mean_error=mean(error);

hold on
subplot(2,1,1)
plot(x,y,'.',x,yy,'r','LineWidth',2);
subplot(2,1,2)
stem(x,error)
hold off
