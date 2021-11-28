        % 根据部件A和部件B的状态判断节点状态        
        function state = judge_node_state(~, A_state, B_state)
            if A_state == 0
                if B_state == 0
                    state = 0;
                    return;
                end
                if B_state == 1
                    state = 3;
                    return;
                end
                if B_state == 2
                    state = 1;
                    return;
                end
            end
            if A_state == 1
                if B_state == 0
                    state = 1;
                    return
                end
                if B_state == 1
                    state = 5;
                    return
                end
                if B_state == 2
                    state = 1;
                    return;
                end
            end
            if A_state == 2
                if B_state == 0
                    state = 2;
                    return;
                end
                if B_state == 1
                    state = 3;
                    return;
                end
                if B_state == 2
                    state = 4;
                    return;
                end
            end
            if A_state == 3
                state = 4;
                return;
            end
        end