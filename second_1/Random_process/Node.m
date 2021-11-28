classdef Node
    % 节点的数据成员
    properties
        A_state                                         % 部件A的状态
        B_state                                         % 部件B的状态
    end
    methods
        % 节点初始化函数
        function obj = Node(a_state, b_state)
            obj.A_state = a_state;
            obj.B_state = b_state;
        end
        % 获得部件A的状态
        function state = get_A_state(obj)
            state = obj.A_state;
        end
        % 获得部件B的状态
        function state = get_B_state(obj)
            state = obj.B_state;
        en
        % 设置部件A的状态
        function obj = set.A_state(obj, state)
            obj.A_state = state;
        end
        % 设置部件B的状态
        function obj = set.B_state(obj, state)
            obj.B_state = state;
        end
    end
end