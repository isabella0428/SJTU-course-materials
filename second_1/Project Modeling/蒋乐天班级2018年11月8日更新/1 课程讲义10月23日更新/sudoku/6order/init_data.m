%数独游戏阶数
Order=6;

%mark表格，下标含义：行坐标，列坐标，数项
cur_mark=ones(Order,Order,Order); 

%记录每一步的mark表格变化
%%第4维下标代表第几格（从1到Order*Order对应从左到右，逐行向下）
diff_mark=zeros(Order,Order,Order,Order*Order);

%数项选择指针
%%下标表示第几格，数值代表下一轮将对应的数项
ptrs=ones(1,Order*Order);

%数格成组定义
%%第3维下标表示第几组
%%数值含义：行坐标，列坐标
groups=zeros(Order,2,6);
groups(:,:,1)=[1 1; 1 2; 1 3; 2 1; 2 2; 2 3];
groups(:,:,2)=[1 4; 1 5; 1 6; 2 4; 2 5; 2 6];
groups(:,:,3)=[3 1; 3 2; 3 3; 4 1; 4 2; 4 3];
groups(:,:,4)=[3 4; 3 5; 3 6; 4 4; 4 5; 4 6];
groups(:,:,5)=[5 1; 5 2; 5 3; 6 1; 6 2; 6 3];
groups(:,:,6)=[5 4; 5 5; 5 6; 6 4; 6 5; 6 6];

%预先已填的数字
%%数值含义：行坐标，列坐标，数项
init_digit=[1 1 4; 1 6 1; 2 3 2; 2 4 3; 3 2 5; 3 5 3;
    4 2 6; 4 5 4; 5 3 5; 5 4 4; 6 1 1; 6 6 5];
for i=1:size(init_digit,1)
    cur_mark=refresh_mark(groups,cur_mark,init_digit(i,1),init_digit(i,2),init_digit(i,3));
end

%记录搜索过程,预开足够多个记录单元
cell_record=zeros(1,1000);
cell_record_ptr=1;
