% 读取csv文件中的数据
df=csvread("dataform2018.csv");	
% 种群规模为100，基因长度为90，选择率为0.8，突变率0.4，终止稳定迭代次数为50代
GA = Population(df,100, 90, 0.8, 0.4, 50);
% 执行遗传算法 GA 的进化过程
GA.evolution();