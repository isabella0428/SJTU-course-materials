classdef Population
    %% 数据成员
    properties
        selection_rate                                                      % 选择率
        gene_length                                                         % 个体基因长度
        mutation_rate                                                       % 突变率
        size                                                                % 种群规模
        continue_iterations                                                 % 稳定遗传带数
        now                                                                 % 当代种群中的个体
        df                                                                  % 题目中的数据文件
    end
    %% 成员函数
    methods
        %% 种群的初始化构造函数
        function obj = Population(df,population_size, gene_length, ...
                selection_rate, mutation_rate, continue_iterations)
            obj.selection_rate = selection_rate;
            obj.gene_length = gene_length;
            obj.mutation_rate = mutation_rate;
            obj.size = population_size;
            obj.continue_iterations = continue_iterations;
            obj.now = Chromosome.empty(0, obj.size);
            obj.df=df
            for i = 1 :obj.size                                             % 种群组成随机初始化
                obj.now(i) = Chromosome(obj.df,obj.gene_length);
            end
        end
        %% 记录种群中个体的可能性
        function probability = calc_probability(obj)                        % 计算当前个体对应的可能性
            all_fitness = sum([obj.now.fitness]);
            probability = [obj.now.fitness] / all_fitness;
        end
        % 选择种群中的一对个体
        function [index1, index2] = selection(obj, probability)
            p_range = zeros(1, obj.size);
            before = 0;
            for i = 1 : obj.size                                            % 轮盘赌选择
                p_range(i) = before + probability(i);
                before = before + probability(i);
            end
            p = random('unif', 0, 1, [1, 2]);                               % 生成两个随机数，挑选合适个体
            if p(1) <= p_range(1)
                index1 = 1;
            else
                for i = 1 : obj.size - 1
                    if p_range(i) <= p(1) && p(1) <= p_range(i + 1)
                        index1 = i + 1;
                        break
                    end
                end
            end
            if p(2) <= p_range(1)
                index2 = 1;
            else
                for i = 1 : obj.size - 1
                    if p_range(i) <= p(2) && p(2) <= p_range(i + 1)
                        index2 = i + 1;
                        break
                    end
                end
            end
        end
        
        % 单个个体变异
        function obj1 = mutation(~, obj1, gene_length)
            for i=1:20                                                      % 20个基因点突变
            mutation_point = randi(gene_length, 1);
            obj1.Gene(mutation_point) = 1 - obj1.Gene(mutation_point);
            obj1.fitness = obj1.calc_fitness();
            end
        end
        % 返回当代最优个体编号
        function index = best_fitness_index(obj)
            index = 1;
            for i = 1 : obj.size
                if obj.now(i).fitness > obj.now(index).fitness              % 找到最大适应度的个体编号 
                    index = i;
                end
            end
        end
        
        % 单点交叉两个个体
        function cross = crossover(obj, index1, index2, gene_length)
            C1 = obj.now(index1);
            C2 = obj.now(index2);
            crossover_point = randi(1, gene_length);                       % 随机生成交叉点 
            cross = Chromosome(obj.df,gene_length);
            for i = 1 : gene_length
                if i <= crossover_point                                    % 根据交叉点交叉
                    cross.Gene(i) = C1.Gene(i);
                else
                    cross.Gene(i) = C2.Gene(i);
                end
            end
            cross.fitness = cross.calc_fitness();                          % 重新计算交叉后个体的适应度
        end 
        
        % 最终的进化函数
        function evolution(obj)
            best_solution = -10000000;                                     % 适应度下界     
            best_method = Chromosome(obj.df,obj.gene_length);
            continuous_iterations = 0;                                     % 稳定迭代次数
            iterations = 0;                                                % 当前迭代次数
            while continuous_iterations < obj.continue_iterations          % 结束条件达到最大稳定迭代次数
                n = max(int64(obj.size * obj.selection_rate), 1);          % 挑选个体
                Child = Chromosome.empty(0, n);
                for i = 1 : n
                    probability = obj.calc_probability();                  % 计算可能性
                    [index1, index2] = obj.selection(probability);         % 返回挑选子代父母亲的编号
                    child = obj.crossover(index1, index2, obj.gene_length);% 返回交叉后子代
                    if random('unif', 0, 1) < obj.mutation_rate            % 突变基因
                        child = obj.mutation(child, obj.gene_length);
                    end
                    Child(i) = child;
                end
                [~, ind] = sort([obj.now.fitness]);                        % 淘汰父代个体
                obj.now = obj.now(ind);
                obj.now = obj.now(n + 1: end);
                obj.now = [obj.now, Child];
                new_best_index = obj.best_fitness_index();                 % 当前最优个体编号
                new_best_solution = obj.now(new_best_index).fitness;       % 当前最优个体的适应性
                new_best_method = obj.now(new_best_index);                 % 当前最优标定方案
                if new_best_solution == best_solution                      % 比较当前最优解和历史最优解
                    continuous_iterations = continuous_iterations + 1;
                    iterations = iterations + 1;
                elseif new_best_solution > best_solution
                        continuous_iterations = 0;
                        best_method = new_best_method;
                        best_solution = new_best_solution;
                        iterations = iterations + 1;
                else
                    continuous_iterations = continuous_iterations + 1;
                    obj.now = [obj.now, best_method];
                    obj.size = obj.size + 1;
                    iterations = iterations + 1;
                    continue
                end
                fprintf('iteration %d, best method %s, ',...              % 输出本代结束后的历史最优结果
                    iterations, best_method.get_gene());
                fprintf('best solution %f, continue iterations %d\n',...
                    -best_solution, continuous_iterations);
                
            end
            fprintf('best solution %f, best method %s\n',...              % 输出最终得到的历史最优结果
               -best_solution, best_method.get_gene());                                                                          
            end
        end
end