classdef Simulation
    properties
        time
        k
        P_EA1
        P_EA2
        P_EA3
        scale_A
        scale_B
        P_EB1
        P_EB2
        num
        A_lifetime
        B_lifetime
        A_fault
        B_fault
        largest_time
        system
    end
    methods
        function obj = Simulation(node_number, k_node)
            obj.time = 0;
            obj.k = k_node;
            obj.P_EA1 = 0.23;
            obj.P_EA2 = 0.27;
            obj.P_EA3 = 0.50;
            obj.scale_A = 9.55 * 10 ^ 4;
            obj.scale_B = 2.9 * 10 ^ 5;
            obj.P_EB1 = 0.73;
            obj.P_EB2 = 0.27;
            obj.num = node_number;
            [obj.A_lifetime, obj.B_lifetime] = obj.generate_lifetime();
            [obj.A_fault, obj.B_fault] = obj.generate_fault();
            obj.largest_time = max(max(obj.A_lifetime), max(obj.B_lifetime));
            obj.system = Node.empty(0, obj.num);
            for i = 1 : obj.num
                obj.system(i) =  Node(0, 0);
            end
        end
        
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
        function Q = get_Q(obj)
            Q = zeros(1, 6);
            for i = 1 : obj.num
                state = obj.judge_node_state(obj.system(i).get_A_state(), obj.system(i).get_B_state());
                state = state + 1;
                Q(state) = Q(state) + 1;
            end
        end
        function Q0 = get_Q0(obj)
           Q = obj.get_Q();
           Q0 = Q(1);
        end
        function Q1 = get_Q1(obj)
           Q = obj.get_Q();
           Q1 = Q(2);
        end
        function Q2 = get_Q2(obj)
           Q = obj.get_Q();
           Q2 = Q(3);
        end
        function Q3 = get_Q3(obj)
           Q = obj.get_Q();
           Q3 = Q(4);
        end
        function Q4 = get_Q4(obj)
           Q = obj.get_Q();
           Q4 = Q(5);
        end
        function Q5 = get_Q5(obj)
           Q = obj.get_Q();
           Q5 = Q(6);
        end
        function state = get_Q2_and_Q3(obj)
            if (obj.get_Q2() + obj.get_Q3()) > 0
                state = 1;
                return;
            else
                state = 0;
                return;
            end
        end
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
        function [lifetime_a, lifetime_b] = generate_lifetime(obj)
            lifetime_a = exprnd(obj.scale_A, 1, obj.num);
            lifetime_b = exprnd(obj.scale_B, 1, obj.num);
            lifetime_a = floor(lifetime_a);
            lifetime_b = floor(lifetime_b);
        end
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
        function state = is_system_failed(~, system_state)
            if system_state == 1 || system_state == 4
                state = true;
            else
                state = false;
            end
        end
        function time = simulate(obj)
            lifetime = [obj.A_lifetime, obj.B_lifetime];
            fault = [obj.A_fault, obj.B_fault];
            system_failed = false;
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