import matplotlib.pyplot as plt
import numpy as np
plt.style.use("ggplot")
n = np.arange(4, 13, 1)
R = [0.4739, 0.7762, 0.8898, 0.9155, 0.9097, 0.8960, 0.8785, 0.8583, 0.8387]
life_time = [29889, 47383, 56119, 59797, 60476, 59844, 58499, 56591, 54769]
plt.plot(n, R)
plt.plot(n, R, "o")
plt.xlabel("$n$")
plt.ylabel("$Reliability$")
plt.show()
