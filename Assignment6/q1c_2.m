clc;
close all;
clear all;

filename = 'arctic_a0008.wav';
[data, srate] = audioread(filename);
info = audioinfo(filename);
speech = data(:,1);
egg = data(:,2);
s1 = 10000;
s2 = 10800;
x = speech(s1:s2);
n = size(x,1);

[A, residual] = lp_analysis(x, 8);

gvv = zeros(n, 1);
gvv(1) = residual(1);
for i = 2:n
    gvv(i) = gvv(i-1)+residual(i);
end

% figure;
% plot(egg(s1:s2), 'DisplayName', 'egg');
% legend('-DynamicLegend');
% hold on;
% plot(gvv, 'DisplayName', 'gvv');
% hold on;
% plot(x, 'DisplayName', 'signal');

%--------QUESTION 2-------------    
autocorr = xcorr(gvv);
[m1, i1] = maxk(autocorr, 3);
p_samples = i1(1)-i1(2);
f = srate/p_samples;
T = 1/f;

NAQ = zeros(n, 1);
duration = 20/1000*srate;
for i = 1:n-duration
    signal = gvv(i:i+duration-1);
    a_peak = max(signal(:));
    der = diff(signal);
    d_peak = min(der(:));

    NAQ(i) = a_peak/(d_peak*T);
end

av_NAQ = mean(NAQ(:));
disp(abs(av_NAQ));

G = fftshift(abs(fft(gvv, 256)));
figure, plot(G);
title('Spectral analysis of GVV');
[m1, i1] = maxk(G, 3);
H = i1(1)-i1(2);
disp(abs(H));