%������Ϸ����
Order=6;

%mark����±꺬�壺�����꣬�����꣬����
cur_mark=ones(Order,Order,Order); 

%��¼ÿһ����mark���仯
%%��4ά�±����ڼ��񣨴�1��Order*Order��Ӧ�����ң��������£�
diff_mark=zeros(Order,Order,Order,Order*Order);

%����ѡ��ָ��
%%�±��ʾ�ڼ�����ֵ������һ�ֽ���Ӧ������
ptrs=ones(1,Order*Order);

%������鶨��
%%��3ά�±��ʾ�ڼ���
%%��ֵ���壺�����꣬������
groups=zeros(Order,2,6);
groups(:,:,1)=[1 1; 1 2; 1 3; 2 1; 2 2; 2 3];
groups(:,:,2)=[1 4; 1 5; 1 6; 2 4; 2 5; 2 6];
groups(:,:,3)=[3 1; 3 2; 3 3; 4 1; 4 2; 4 3];
groups(:,:,4)=[3 4; 3 5; 3 6; 4 4; 4 5; 4 6];
groups(:,:,5)=[5 1; 5 2; 5 3; 6 1; 6 2; 6 3];
groups(:,:,6)=[5 4; 5 5; 5 6; 6 4; 6 5; 6 6];

%Ԥ�����������
%%��ֵ���壺�����꣬�����꣬����
init_digit=[1 1 4; 1 6 1; 2 3 2; 2 4 3; 3 2 5; 3 5 3;
    4 2 6; 4 5 4; 5 3 5; 5 4 4; 6 1 1; 6 6 5];
for i=1:size(init_digit,1)
    cur_mark=refresh_mark(groups,cur_mark,init_digit(i,1),init_digit(i,2),init_digit(i,3));
end

%��¼��������,Ԥ���㹻�����¼��Ԫ
cell_record=zeros(1,1000);
cell_record_ptr=1;
