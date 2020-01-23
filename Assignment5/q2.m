clc;
close all;
clear all;

filename = 'arctic_a0008.wav';
[data, srate] = audioread(filename);
info = audioinfo(filename);
speech = data(:,1);
n = size(speech,1);
x = speech(1:n);

N = 256;
wsize = n/2;
window = hamming(wsize);
xbar = conv(x, window);
X = fft(xbar, N);

f = 0: 2*pi/N: 2*pi *(N-1)/N;
F = fftshift(f);
w = unwrap(F - 2*pi);
plot(w, abs(fftshift(X)));
title('256 points, hamming window of size n/2');
xlabel('Frequency');
ylabel('Magnitude');