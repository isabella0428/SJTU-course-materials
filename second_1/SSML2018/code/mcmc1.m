%% Init()
n = 250000000;
t0 = 200000000;
P = [0.3, 0.2, 0.5; 
    0.4, 0.2, 0.4; 
    0.4, 0.3, 0.3];
C = cumsum(P, 2);
state = zeros(1, n);
r = unifrnd(0, 1, [1, n]);
i0 = 1;
current = i0;
%% MCMC
for time = 1 : n
    j = 1;
    while r(time) > C(current, j)
        j = j + 1;
    end
    state(time) = j;
    current = j;
end
%% Plot the histogram and bar plot
h = hist(state(t0 + 1 : n), [1, 2, 3]);
bar(h / (n - t0));
disp(h / (n - t0));
