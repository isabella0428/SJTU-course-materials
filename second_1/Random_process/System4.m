        % 统计满足一定条件的节点数量
        function Q = get_Q(obj)
            Q = zeros(1, 6);
            for i = 1 : obj.num
                state = obj.judge_node_state(obj.system(i).get_A_state(), obj.system(i).get_B_state());
                state = state + 1;
                Q(state) = Q(state) + 1;
            end
        end
        % 返回满足条件Q0的节点数量
        function Q0 = get_Q0(obj)
           Q = obj.get_Q();
           Q0 = Q(1);
        end
        % 返回满足条件Q1的节点数量
        function Q1 = get_Q1(obj)
           Q = obj.get_Q();
           Q1 = Q(2);
        end
        % 返回满足条件Q2的节点数量
        function Q2 = get_Q2(obj)
           Q = obj.get_Q();
           Q2 = Q(3);
        end
        % 返回满足条件Q3的节点数量
        function Q3 = get_Q3(obj)
           Q = obj.get_Q();
           Q3 = Q(4);
        end
        % 返回满足条件Q4的节点数量
        function Q4 = get_Q4(obj)
           Q = obj.get_Q();
           Q4 = Q(5);
        end
        % 返回满足条件Q5的节点数量
        function Q5 = get_Q5(obj)
           Q = obj.get_Q();
           Q5 = Q(6);
        end
        % 返回是否同时有满足条件Q2和Q3的节点
        function state = get_Q2_and_Q3(obj)
            if (obj.get_Q2() + obj.get_Q3()) > 0
                state = 1;
                return;
            else
                state = 0;
                return;
            end
        end