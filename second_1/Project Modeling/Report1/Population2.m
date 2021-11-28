        
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
