clc;
close all;
clear all;

filename = 'my_name.wav';
[data, srate] = audioread(filename);
info = audioinfo(filename);
speech = data(:,1);
segment = speech(1:10000);

%--------PART D-----------
[coeffs, residual] = lp_analysis(segment, 8);
autocorrelation = xcorr(residual);

figure, plot(segment, 'DisplayName','Segment');
legend('-DynamicLegend');
hold on;
plot(residual, 'DisplayName', 'Residual');

figure, plot(autocorrelation);
title('Autocorrelation of LP residual');

%--------PART E------------
[m, i] = maxk(autocorrelation, 3);
speriod = abs(i(1)-i(2));
pitch = srate/speriod;
period = 1/pitch;
disp('Pitch is');
disp(pitch);
disp('Period is');
disp(period);

