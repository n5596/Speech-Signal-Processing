% function [A, residual] = lp(x, p)
    n = size(x, 1);
    gamma = zeros(p, 1);
    r = zeros(p, 1);
    R = zeros(p, p);
    
     for i = 1:p
        s1 = x;
        s2 = circshift(x,i);
        S = s1.*s2;
        gamma(i) = sum(S(:));
     end
    
    for i = 0:p-1
        s1 = x;
        s2 = circshift(x,i);
        S = s1.*s2;
        r(i+1) = sum(S(:));
     end
    
    for i = 1:p
        if i == 1
            R(i,:) = r;
        else
            R(i,:) = circshift(r,i-1);
        end
    end
    
    A = inv(R)*gamma;
    A = transpose(A);
    
    predicted = filter([0 A(1:end)],1,x);
    
    residual = x - predicted;
    t = 0:n-1;
    plot(t, predicted, 'DisplayName', 'predicted');
    legend('-DynamicLegend');
    hold on;
    plot(t, x, 'DisplayName', 'speech');
    hold on;
    plot(t, residual, 'DisplayName', 'residual');

% end