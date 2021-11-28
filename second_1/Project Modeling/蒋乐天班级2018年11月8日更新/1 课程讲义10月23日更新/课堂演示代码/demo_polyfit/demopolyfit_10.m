%polyfit���Զ����ݽ�����ϣ��Զ����ü��ζ���ʽ����������Ӧ�Ĳ�����
%polyval����������Ϻ�����ݵ㣬
%��������������Ƕ�������y=3x2+6x+5�������

x = -5:0.1:5;
y = 3*x.^2+6*x + 5 + randn(size(x)); %��ʵ���л�����һ���������
p = polyfit(x,y,2); %���ζ���ʽ��ϣ�p��ʵ�Ƕ�Ӧ�Ĳ�������ֵ
yy = polyval(p,x); %���ζ���ʽ��ϣ�yyΪ������ݵ�
error=yy-y; max_error=max(error);mean_error=mean(error);

p_10=polyfit(x(1:10:101),y(1:10:101),2);
yy_10=polyval(p_10,x(1:10:101));
error_10=yy_10-y(1:10:101);max_error_10=max(error_10);mean_error_10=mean(error_10);

hold on
plot(x,y,'.',x,yy,'r','LineWidth',2);
plot(x,y,'.',x(1:10:101),yy_10,'k','LineWidth',2);
hold off
fprintf('mean_error=%s \n',mean_error);
fprintf('mean_error_10=%s \n',mean_error_10);