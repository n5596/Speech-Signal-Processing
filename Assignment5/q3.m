clc;
close all;
clear all;

filename = 'na.wav';
[data, srate] = audioread(filename);
info = audioinfo(filename);
speech = data(:,1);
x = speech;

%--------USING LP ANALYSIS---------
[A, residual] = lp_analysis(x, 8);
lp_corr = xcorr(residual);
[m1, i1] = maxk(lp_corr, 3);

speriod1 = abs(i1(1)-i1(2));
pitch1 = srate/speriod1;
period1 = 1/pitch1;

% disp('Pitch is');
% disp(pitch1);
% disp('Pitch period is');
% disp(period1);

%--------USING CEPSTRAL ANALYSIS-----
X = abs(fft(x, 1024));
cepstrum = ifft(log(X));
coeffs = cepstrum(1:size(cepstrum,1)/2);
lifter = zeros(size(coeffs,1),1);
lifter(15:size(lifter,1)) = 1;
lfc = real(lifter.*coeffs);
[m2, i2] = maxk(lfc, 3);
pitch2 = srate/i2(1);
period2 = 1/pitch2;

disp('Pitch is');
disp(pitch2);
disp('Pitch period is');
disp(period2);

plot(lfc);
title('Liftered signal');