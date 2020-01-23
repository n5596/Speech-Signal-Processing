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

dx = diff(x);
M = 50;
N = 128;
s = zeros(N, 1);
s(1:M) = dx(1:M);

w = zeros(N, 1);
for n = 1:N
    if n == 1
        w(n) = 0;
    else
        d = 4*sin(pi*n/(2*N))^2;
        w(n) = 1/d;
    end
end

xbar = w .* s;
X = fftshift(fft(xbar, N));
NGD = zeros(N, N);
rx = real(X);
ix = imag(X);

for i = 1:N
    for n = 1:N
       y = n*xbar;
       Y = fftshift(fft(y, N));
       ry = real(Y);
       iy = imag(Y);
       array = rx.*ry + ix.*iy;
       NGD(n,:) = array;
    end
end

[X,Y] = meshgrid(0.1*N:-0.1:0.1,0.1:0.1:0.1*N);
Z = NGD;
surf(X, Y, Z');
xlabel('Time ms');
ylabel('Freq kHz');
title('ZTW based spectrogram');
% set(gca,'Ydir','reverse');
view(70, 70);

figure;
spectrogram(x, w, N/4, N, srate, 'yaxis');
view(-10, 50);
title('STFT based spectrogram');