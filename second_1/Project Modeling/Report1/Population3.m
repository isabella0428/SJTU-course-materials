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