classdef Chromosome
    %% 数据成员
    properties
        length                                                    % 基因长度
        Gene                                                      % 基因序列
        fitness                                                   % 个体适应度
        df                                                        % 题目中的数据文件
    end
    %% 成员函数
    methods
        %% 个体(Chromosome)类的构造函数
        function obj = Chromosome(df,n)
            obj.df=df;
            obj.length = n;
            obj.fitness = 0;
            obj.Gene = randi([0, 1], [1, n]);                     % 随机生成个体基因序列 
            obj.fitness = obj.calc_fitness();                     % 计算个体的适应度
        end
        %% 计算个体适应度函数
        function fitness = calc_fitness(obj)
           all=0;
           X_=1:90;
           X_=X_(obj.Gene~=0);  %not empty indices                % 对采样温度点进行计算
           for i=1:500
               Y=obj.df(2*i,X_);
               X=-20:69;
               X=X(X_);
               X_i=spline(Y,X,obj.df(2*i,:));                     % 三次样条插值处理
               for j=1:90
                   X=-20:69;
                   if abs(X_i(j)-X(j))<1&&abs(X_i(j)-X(j))>0.5    % 根据误差计算成本
                           all=all+1;
                   end
                   if abs(X_i(j)-X(j))<1.5&&abs(X_i(j)-X(j))>1
                               all=all+4;
                   end
                   if abs(X_i(j)-X(j))<2&&abs(X_i(j)-X(j))>1.5
                       all=all+10;
                   end
                   if abs(X_i(j)-X(j))>2
                       all=all+10000;
                   end
               end
               all=all+50*max(size(X_));
           end
           fitness=-all/500;                                      % 返回适应度值
        end
        %% 返回基因序列的字符串形式
        function a=get_gene(obj)
            a='';
            for i=1:obj.length
                if obj.Gene(i)==0
                    a=a+'0';
                else
                    a=a+'1';
                end
            end
        end
    end
end