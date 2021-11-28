import matplotlib.pyplot as plt
import numpy as np
plt.style.use("ggplot")
n = np.arange(4, 13, 1)
life_time = [29889, 47383, 56119, 59797, 60476, 59844, 58499, 56591, 54769]
life_time_1 = [43456, 59711, 64107, 64119, 62577, 60664, 58410, 56154, 54292]
life_time_2 = [30651, 49744, 59975, 65080, 67253, 67887, 67653, 66988, 66146]
life_time_3 = [38786, 57344, 64847, 67014, 67198, 66347, 64957, 63752, 62354]
plt.plot(n, life_time, label="Old System")
plt.plot(n, life_time, "o")
plt.plot(n, life_time_1, label="Method 1")
plt.plot(n, life_time_1, "o")
plt.plot(n, life_time_2, label="Method 2")
plt.plot(n, life_time_2, "o")
plt.plot(n, life_time_3, label="Method 3")
plt.plot(n, life_time_3, "o")
plt.xlabel("$n$")
plt.ylabel("$Life\ time$")
plt.legend()
plt.show()