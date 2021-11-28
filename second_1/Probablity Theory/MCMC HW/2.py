import matplotlib.pyplot as plt
import numpy as np

plt.style.use('seaborn')
N = np.logspace(1, 6, 80)
result = []
for item in N:
    item = int(item)
    X = np.random.randn(item)
    Y = np.sqrt(2*np.pi)*np.exp(-X*X*5/2)
    result.append(sum(Y)/item)

plt.scatter(N, result, label='estimated value')
plt.xscale('log')

plt.plot([10, 10 ** 6], [np.sqrt(2*np.pi)/np.sqrt(6),
np.sqrt(2*np.pi)/np.sqrt(6)], 'y', linewidth=2, 
label='real value')

plt.legend()
plt.show()