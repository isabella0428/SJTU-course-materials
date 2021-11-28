function [W1, W2] = MultiClass(W1, W2, X, D)
    alpha = 0.9;
    N = 5;
    for i = 1 : N
        x = reshape(X(:, :, i), 25, 1);
        d = D(i, :)';
        
        v1 = W1 * x;
        u1 = Sigmoid(v1);
        
        v2 = W2 * u1;
        u2 = softmax(v2);
        
        error = d - u2;
        delta = error;
        
        error1 = W2' * delta;
        delta1 = u1 .* (1 - u1) .* error1;
        
        dw1 = alpha * delta1 * x';
        W1 = W1 + dw1;
        
        dw2 = alpha * delta * u1';
        W2 = W2 + dw2;
    end
end