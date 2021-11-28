function find_result(node_number, k_node, n_epoches, w)
    % 函数目的：寻找给定参数下系统的可靠性和平均寿命
    % 输入：node_number 节点个数
    % 输入：k_node 最小节点个数
    % 输入：n_epoches 模拟系统的个数
    % 输入：w 计算可靠性需要的比较时间
    % 输出：系统的平均寿命和可靠性
    time_array = zeros(1, n_epoches);
    % 对每一套进行蒙特卡洛仿真模拟
    for i  = 1 : n_epochesr
        fprintf("Epoch %d\n", i);
        simulation = Simulation(node_number, k_node);
        time_arary(i) = simulation.simulate();
    end
    R_w = length(find(time_arary >= w));
    % 输出平均寿命和可靠性
    fprintf("Average life time %.3f\n", mean(time_arary));
    fprintf("Reliability %.3f\n", R_w / n_epoches);
end