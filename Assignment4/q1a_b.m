clc;
close all;
clear all;

%--------PART A--------------
f = 300;
Fs = 8000; 
T = 1/Fs;
B = 50; 

f1 = 1;
f2 = -2*exp(-pi*B*T)*cos(2*pi*f*T);
f3 = exp(-2*pi*B*T);

a=1;
b=[f1,f2,f3];

figure,freqz(a,b,6000,6000);
title('Magnitude and phase');

%-------PART B---------------
impulse = [zeros(1,10) 1 zeros(1,110)];
y = filter(a,b,impulse);
figure, plot(impulse);
title('Impulse');
figure, plot(y);
title('Resonator response');