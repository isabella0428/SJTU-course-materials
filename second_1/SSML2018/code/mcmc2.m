%% Init()
f = [0, 1, 2, 3, 4, 5, 6 ...
    , 5, 4, 3, 2, 1];
d = zeros(1, 20000);
x = 5;
%% Start MCMC Process
for i = 1 : 20000
    U = rand;
    if x == 2
        if U < 0.5
            y = 3;
        else
            y = 2;
        end
    elseif x == 12
        if U < 0.5
            y = 11;
        else
            y = 12;
        end
    else
            if U < 0.5
                y = x - 1;
            else
                y = x + 1;
            end
    end
    h = min(1, f(y) / f(x));
    U = rand;
    if U < h
        x = y;
    end
    d(i) = x;
end
%% Plot the result
h = hist(d , [1:1:12]);
b = h / sum(h);
bar(b);