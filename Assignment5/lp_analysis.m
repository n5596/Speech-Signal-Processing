function [A, residual] = lp_analysis(x, p)
    n = size(x, 1);
    gamma = zeros(p, 1);
    R = zeros(p, p);
    
    shifted = zeros(size(x,1), p);
    for i = 1:p
        for j = i+1:size(x, 1)
            shifted(j,i) = x(j-i);
        end
    end
    for i = 1:p
        s1 = x;
        s2 = shifted(:,i);
        S = s1.*s2;
        gamma(i) = sum(S(:));
    end
    
    for i = 1:p
        for k = 1:p
            s1 = shifted(:,i);
            s2 = shifted(:,k);
            S = s1.*s2;
            R(i,k) = sum(S(:));
        end
    end
    A = inv(R)*gamma;
    A = transpose(A);
        
    predicted = filter([0 A(1:end)],1,x);

    residual = (x - predicted);
%     t = 0:n-1;
%     plot(t, predicted, 'DisplayName', 'predicted');
%     legend('-DynamicLegend');
%     hold on;
%     plot(t, x, 'DisplayName', 'speech');
%     hold on;
%     plot(t, residual, 'DisplayName', 'residual');

end