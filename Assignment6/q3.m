clc;
close all;
clear all;

filename = 'arctic_a0008.wav';
[data, srate] = audioread(filename);
info = audioinfo(filename);
speech = data(:,1);
egg = data(:,2);
x = speech(1:50000);
n = size(x,1);
x = x*10;

[A, residual] = lp_analysis(x, 8);
N = 256;
[upper, lower] = envelope(residual, N, 'analytic');

freq = 500;
sigma = 0.50;
w = 2*pi*freq; 
gabor = zeros(n, 1);
for i = 1:n
    gabor(i) = 1/(sqrt(2*pi)*sigma)*exp(-i.^2/(2*sigma^2)).*exp(j*w*i); 
end
y = conv(gabor, upper);

dur = 50/1000*srate;
vop = zeros(n, 1);
for i = 1:n
    mx = min(i+dur-1, n);
    signal = y(i:mx);
    vop(i) = real(sum(signal(:)));
end

window = hamming(dur);
smoothed = conv(vop, window);

[pks,locs] = findpeaks(smoothed);
peaks = zeros(n, 1);
for i = 1:size(locs, 1)
   peaks(locs(i)) = 1; 
end

figure;
plot(vop, 'DisplayName', 'vop');
legend('-DynamicLegend');
hold on;
plot(peaks, 'DisplayName', 'peaks');

index = zeros(n, 1);
j = 1;
for i = 1:n
   if peaks(i) == 1
       index(j) = i;
       j = j+1;
   end
end
rhythm = zeros(j-2, 1);

for i = 1:j-2
    rhythm(i) = index(i+1)-index(i);
end

% figure;
% plot(rhythm); title('Rhythm');

duration = 30/1000*srate;
F0 = zeros(n, 1);
for i = 1:n-1
    my = min(i+duration-1, n);
    sg = x(i:my);
    ag = xcorr(sg);
    [m2, i2] = maxk(ag, 3);
    F0(i) = srate/abs(i2(1)-i2(2));
end

intonation = zeros(n, 1);
for i = 1:n-1
    intonation(i) = F0(i+1)-F0(i);
end

stress = zeros(n, 1);
for i = 1:n-duration
    mz = min(i+duration-1, n);
    sgg = x(i:mz);
    ssgg = sgg .^ 2;
    esg = sum(ssgg(:));
    stress(i) = log(esg);
end