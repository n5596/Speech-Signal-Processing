clc;
close all;
clear all;

filename = 'my_name.wav';
[data, srate] = audioread(filename);
info = audioinfo(filename);
speech = data(:,1);

n = 10*srate/1000;
overlap = n/4;
window= hanning(n, 'periodic');

figure;
subplot(2,1,1);
t = 1/srate:1/srate:(size(speech,1)/srate);
plot(t, speech);
title('Speech Signal');
subplot(2,1,2);
spectrogram(speech, window, overlap, n, srate, 'yaxis');
view(-10, 50);
title('STFT');

