clc;
close all;
clear all;

filename = 'na.wav';
[data, srate] = audioread(filename);
info = audioinfo(filename);
speech = data(:,1);
x = speech;

N = 256;
window = 20*srate/1000;
residual = zeros(size(speech,1),1);
figure, plot(speech);
title('Speech signal');

for i = 1:window/2:size(speech,1)-window
    segment = x(i:i+window-1);
    [A, r] = lp_analysis(segment, 10);
    residual(i:i+window-1) = r;
end
% [A, residual] = lp_analysis(x, 8);
[upper, lower] = envelope(residual, N, 'analytic');

t1 = 1:size(upper);
figure, plot(t1,upper,t1,lower,'linewidth',1.5);
title('Hilbert envelope of the LP residual');

samples = 50*srate/1000;
window = hamming(samples);
S = conv(upper, window);
t2 = 1:size(S);
figure, plot(t2, S);
title('Convolution of Hilbert envelope and hamming window');

fodS = diff(S);
s_samples = 5*srate/1000;

peaks_array = zeros(10000, 1);
k = 1;

for i = 1:size(S,1)-1
    if S(i)>0 && S(i+1)<0
        x = max(1,i-s_samples);
        y = min(i+s_samples-1,size(S,1));
        signal = S(x:y,1);
        m = mean(signal(:));
        if S(i)>0.5*m
            peaks_array(k) = i;
            k = k+1;
        end
    end
end

for i = 1:k-2
    if peaks_array(i+1)-peaks_array(i)<samples
        v1 = S(peaks_array(i));
        v2 = S(peaks_array(i+1));
        if v1<v2
            S(peaks_array(i)) = 0;
        else
            S(peaks_array(i+1)) = 0;
        end
    end
end

nS = normalize(S, 'range', [0 1]);
figure, plot(nS);
title('Enhanced values');

sigma = 5;
gsize = 100*srate/1000;    
g = linspace(-gsize / 2, gsize / 2, gsize);
gaussFilter = exp(-g .^ 2/(2 * sigma ^ 2));
gaussFilter = gaussFilter/sum (gaussFilter);

dgauss = diff(gaussFilter);
vop = conv(dgauss, nS);
vop = normalize(vop, 'range', [-1 1]);
t_vop = zeros(size(vop,1),1);
threshold = mean(vop(:));

[peaks, locs] = findpeaks(vop);
threshold = 0.5;

for i = 1:size(locs,1)
    if peaks(i) > threshold
        t_vop(locs(i)) = 1;
    else
        t_vop(locs(i)) = 0;
    end
end

figure, plot(speech, 'DisplayName', 'speech');
legend('-DynamicLegend');
hold on;
plot(t_vop, 'DisplayName', 'vop');

