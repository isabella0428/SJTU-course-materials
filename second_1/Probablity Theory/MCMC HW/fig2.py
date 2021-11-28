# 调用相应科学计算包
import matplotlib.pyplot as plt
import numpy as np
# 确定生成样本点序列
N = 50
# 设置图片为ggplot风格
plt.style.use('ggplot')
# 初始化相应序列
sample_size = np.logspace(0, 6, N)
integral_result = np.zeros(N)
# 利用期望法近似计算积分
for i, size in enumerate(sample_size):
    X = np.random.normal(0, 1, int(size))
    integral_result[i] = np.sum(np.sqrt(2 * np.pi ) * np.exp(- X**2 ) * np.exp(X**2 / 2)) / size
    print(integral_result[i])
# 设置图片相关格式
plt.xscale('log')
plt.xlabel('$N$')
plt.ylabel('I')
# 绘制积分近似值散点图
plt.scatter(sample_size, integral_result, label="Integral estimate value")
# 绘制积分理论值直线图
plt.plot([1, 10**6], [np.sqrt(np.pi), np.sqrt(np.pi)], 'b-', label="Integral theoretical value")
plt.legend()
plt.show()