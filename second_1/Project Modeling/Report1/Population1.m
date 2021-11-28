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
            p = random('unif', 0, 1, [1, 2]);                               %生成两个随机数，挑选合适个体
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
