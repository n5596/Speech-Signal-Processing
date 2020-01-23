clc;
close all;
clear all;

% filename = 'arctic_a0003.wav';
filename = 'my_name.wav';
[data, srate] = audioread(filename);

audio = data(:, 1);
info = audioinfo(filename);

autocorr = xcorr(audio);
[peaks, locs] = findpeaks(autocorr);
[value, peak1_ind]=max(peaks); 
speriod= locs(peak1_ind+1)-locs(peak1_ind); 
pitch = srate/speriod;
period = 1/pitch;
disp([pitch period]);

t = 1:size(autocorr, 1);
plot(t, autocorr, 'DisplayName', 'autocorr');
title('Autocorrelation');