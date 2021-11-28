import matplotlib.pyplot as plt
import numpy as np
plt.style.use("ggplot")
n = np.arange(4, 13, 1)
R = [0.4739, 0.7762, 0.8898, 0.9155, 0.9097, 0.8960, 0.8785, 0.8583, 0.8387]
R1 = [0.672, 0.899, 0.938, 0.932, 0.916, 0.900, 0.878, 0.8561, 0.83]
R2 = [0.486, 0.799, 0.920, 0.958, 0.965, 0.962, 0.956, 0.948, 0.941]
R3 = [0.605, 0.877, 0.949, 0.959, 0.954, 0.946, 0.933, 0.923, 0.913]
plt.plot(n, R, label="Old System")
plt.plot(n, R, "o")
plt.plot(n, R1, label="Method 1")
plt.plot(n, R1, "o")
plt.plot(n, R2, label="Method 2")
plt.plot(n, R2, "o")
plt.plot(n, R3, label="Method 3")
plt.plot(n, R3, "o")
plt.xlabel("$n$")
plt.ylabel("$Reliability$")
plt.legend()
plt.show()