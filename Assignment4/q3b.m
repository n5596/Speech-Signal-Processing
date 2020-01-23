clc;
close all;
clear all;

filename = 'my_name.wav';
[data, srate] = audioread(filename);
speech = data(:,1);
segment = speech(1:10000);

[coeffs, residual] = lp_analysis(segment, 8);
a = 1;
b = [1,coeffs(1),coeffs(2),coeffs(3),coeffs(4),coeffs(5),coeffs(6), coeffs(7),coeffs(8)];

figure,freqz(a,b,6000,6000);
title('Magnitude and phase of VT response');

figure, plot(speech); title('Speech');