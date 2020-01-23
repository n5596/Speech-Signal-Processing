clc;
close all;
clear all;

filename = 'my_name.wav';
[data, srate] = audioread(filename);
info = audioinfo(filename);
speech = data(:,1);
segment = speech(1:10000);

%-----PART C----------
win = hamming(size(segment,1));
ham_output = segment.*win;
autocorrelation1 = xcorr(ham_output);

%------PART D---------
[coeffs, residual] = lp_analysis(segment, 8);
autocorrelation2 = xcorr(residual);

subplot(2,1,1);
plot(ham_output);
title('Hamming output 2c');
subplot(2,1,2);
plot(residual);
title('Residual 2d');

% subplot(2,1,1);
% plot(autocorrelation1);
% title('Autocorrelation of Hamming window output');
% subplot(2,1,2);
% plot(autocorrelation2);
% title('Autocorrelation of LP residual');

% figure, plot(segment);
% title('Segment of speech');
% figure, plot(ham_output);
% title('Hamming window output');
% figure, plot(autocorrelation1);
% title('Autocorrelation of above signal');