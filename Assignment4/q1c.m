clc;
close all;
clear all;

F1 = 300;
B1 = 50; 
F2 = 1245;
B2 = 110;
F3 = 1892;
B3 = 160;

Fs = 8000; 
T = 1/Fs;

a = -2*exp(-pi*B1*T)*cos(2*pi*F1*T);
b = exp(-2*pi*B1*T);
c = -2*exp(-pi*B2*T)*cos(2*pi*F2*T);
d = exp(-2*pi*B2*T);
e = -2*exp(-pi*B3*T)*cos(2*pi*F3*T);
f = exp(-2*pi*B3*T);

A = 1;
B1 = [1 a b];
B2 = [1 c d];
B3 = [1 e f];

freqz(conv(conv(A,A),A),conv(conv(B1,B2),B3),8000,8000);
title('Magnitude and phase of cascaded filter');

impulse = [zeros(1,10) 1 zeros(1,110)];
y = filter(conv(conv(A,A),A),conv(conv(B1,B2),B3),impulse);
figure, plot(impulse);
title('Impulse');
figure, plot(y);
title('Resonator response');