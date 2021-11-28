        % 根据相应指数分布生成部件A和部件B的寿命
        function [lifetime_a, lifetime_b] = generate_lifetime(obj)
            lifetime_a = exprnd(obj.scale_A, 1, obj.num);
            lifetime_b = exprnd(obj.scale_B, 1, obj.num);
            lifetime_a = floor(lifetime_a);
            lifetime_b = floor(lifetime_b);
        end
        % 根据相应概率生成部件A和部件B的故障类型
        function [A_fault, B_fault] = generate_fault(obj)
            A_fault = zeros(1, obj.num);
            B_fault = zeros(1, obj.num);
            for i = 1 : obj.num
                p1 = unifrnd(0, 1);
                p2 = unifrnd(0, 1);
                A_fault(i) = obj.condition_set_A_state(p1);
                B_fault(i) = obj.condition_set_B_state(p2);
            end
        end
        % 判断系统是否有效
        function state = is_system_failed(~, system_state)
            if system_state == 1 || system_state == 4
                state = true;
            else
                state = false;
            end
        end
        % 对当前系统开始蒙特卡洛模拟
        function time = simulate(obj)
            lifetime = [obj.A_lifetime, obj.B_lifetime];
            fault = [obj.A_fault, obj.B_fault];
            system_failed = false;
            % 检测系统是否失效或者以达到最大时间
            while ~system_failed
                min_lifetime = min(lifetime);
                min_indices = find(lifetime == min_lifetime);
                obj.time = min_lifetime;
                for i = 1 : length(min_indices)
                    index = min_indices(i);
                    state = fault(index);
                    if index > obj.num
                        obj.system(index - obj.num).B_state = state;
                    else
                        obj.system(index).A_state = state;
                    end
                    lifetime(index) = obj.largest_time;
                end
                probability = unifrnd(0, 1);
                system_state = obj.judge_system_state(probability);
                system_failed = obj.is_system_failed(system_state);
                if obj.time >= 75000
                    break
                end
            end
            time = min(obj.time, 75000);
        end                    
    end
end