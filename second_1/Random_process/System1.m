classdef Simulation
    % 模拟类的数据成员
    properties
        time                % 当前时间
        k                   % 最小节点数量
        P_EA1               % A部件第一种故障概率
        P_EA2               % A部件第二种故障概率
        P_EA3               % A部件第三种故障概率
        scale_A             % A部件寿命服从指数分布的参数
        scale_B             % B部件寿命服从指数分布的参数
        P_EB1               % B部件第一种故障的概率
        P_EB2               % B部件第二种故障的概率
        num                 % 数量
        A_lifetime          % A类部件的寿命
        B_lifetime          % B类部件的寿命
        A_fault             % A类部件可能的故障类型
        B_fault             % B类部件可能的故障类型
        largest_time        % 最长工作时间
        system              % 当前系统
    end
    methods
        % 模拟类的初始化函数
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
            [obj.A_lifetime, obj.B_lifetime] = obj.generate_lifetime();         % 生成A、B部件的寿命
            [obj.A_fault, obj.B_fault] = obj.generate_fault();                  % 生成A、B部件的故障类型
            obj.largest_time = max(max(obj.A_lifetime), max(obj.B_lifetime), 75000);
            obj.system = Node.empty(0, obj.num);
            for i = 1 : obj.num
                obj.system(i) =  Node(0, 0);
            end
        end