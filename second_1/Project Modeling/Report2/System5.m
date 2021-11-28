        % 判断系统是否处于状态1
        function state = is_sys_state_1(obj)
        if obj.get_Q5() >= 1 || obj.get_Q3() >= 2 || obj.get_Q0() + obj.get_Q2() + obj.get_Q3() == 0
            state = true;
            return;
        end
        if obj.get_Q0() + obj.get_Q1() + obj.get_Q2_and_Q3() < obj.k
            state = true;
            return;
        end
        state = false;
        end
        % 判断系统是否处于状态2
        function state = is_sys_state_2(obj)
        if obj.get_Q5() == 0
            if obj.get_Q3() == 1 && (obj.get_Q0() + obj.get_Q1() >= obj.k - 1)
                state = true;
                return;
            end
            if obj.get_Q3() == 0 && obj.get_Q0() == 0 && obj.get_Q2() >= 1 && obj.get_Q1() >= obj.k - 1
                state = true;
                return;
            end
            if obj.get_Q3() == 0 && obj.get_Q0() >= 1 && (obj.get_Q0() + obj.get_Q1() >= obj.k)
                state = true;
                return;
            end
        end
        state = false;
        end
        % 判断系统是否处于状态3或4
        function state = is_sys_state_3_or_4(obj, probability)
        threshold = obj.get_Q2() / (obj.get_Q2() + obj.get_Q0());
        if obj.get_Q5() + obj.get_Q3() == 0
            if obj.get_Q0() >= 1 && (obj.get_Q0() + obj.get_Q1() == obj.k - 1) && obj.get_Q2() >= 1
                if probability <= threshold
                    state = 3;
                    return;
                else
                    state = 4;
                    return
                end
            end
        end
        end
        % 返回系统所处于的状态
        function state = judge_system_state(obj, probability)
            if obj.is_sys_state_1()
                state = 1;
                return;
            end
            if obj.is_sys_state_2()
                state = 2;
                return;
            end
            state = obj.is_sys_state_3_or_4(probability);
            
        end