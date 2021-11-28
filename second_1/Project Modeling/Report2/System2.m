        % 根据相关条件概率设置判断A的状态
        function state = condition_set_A_state(obj, probability)
            p1 = obj.P_EA1;
            p2 = p1 + obj.P_EA2;
            p3 = p2 + obj.P_EA3;
            
            if probability <= p1
                state = 1;
                return;
            end
            if probability <= p2
                state = 2;
                return;
            end
            if probability <= p3
                state = 3;
                return;
            end
        end
        % 根据相关条件概率设置判断B的状态
        function state = condition_set_B_state(obj, probability)
            p1 = obj.P_EB1;
            p2 = p1 + obj.P_EB2;
            if probability <= p1
                state = 1;
                return;
            end
            if probability <= p2
                state = 2;
                return;
            end
        end