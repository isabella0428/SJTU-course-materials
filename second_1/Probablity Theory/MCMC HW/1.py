import matplotlib.pyplot as plt
import numpy as np

plt.style.use('seaborn')
N = np.arrange(10, 1000, 1000000)
result = []
for item in N:
    X = np.random.rand(item)
    Y = X*np.exp(X)
    result.append(sum(Y)/item)

plt.scatter(N, result, label='estimated value')

plt.plot([10, 10 ** 6], [np.sqrt(2*np.pi)/np.sqrt(6), 
np.sqrt(2*np.pi)/np.sqrt(6)], 'y', linewidth=2,
label='real value')

plt.legend()
plt.show()