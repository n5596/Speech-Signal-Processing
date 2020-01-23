function [voiced] = find_voiced(speech1, speech2, srate1, srate2)
    voiced = zeros(10000, 4);
    m = 1;

    threshold = 0.93;
    autocorrelation1 = zeros(size(speech1,1),1);
    autocorrelation2 = zeros(size(speech2,1),1);
    
    duration = 20/1000;
    samples = duration * srate1;
    
    j = 1;
    for i = m+1:size(speech1, 1)-samples+1
        s1 = speech1(i:i+samples-1, 1);
        s2 = speech1(i-m:i+samples-1-m, 1);
        n1 = s1 .* s2;
        num = sum(n1(:));
        ss1 = s1 .^2;
        ss2 = s2 .^2;
        d1 = sum(ss1(:));
        d2 = sum(ss2(:));
        denom = sqrt(d1*d2);
        autocorrelation1(i) = num/denom;
        voiced(j,1:2) = [i i+samples-1];
        j = j+1;
    end
    
    j = 1;
    samples = duration * srate2;
    for i = m+1:size(speech2, 1)-samples+1
        s1 = speech2(i:i+samples-1, 1);
        s2 = speech2(i-m:i+samples-1-m, 1);
        n1 = s1 .* s2;
        num = sum(n1(:));
        ss1 = s1 .^2;
        ss2 = s2 .^2;
        d1 = sum(ss1(:));
        d2 = sum(ss2(:));
        denom = sqrt(d1*d2);
        autocorrelation2(i) = num/denom;
        voiced(j,3:4) = [i i+samples-1];
        j = j+1;
    end
    
%     figure, plot(autocorrelation1);
%     figure, plot(autocorrelation2);

end