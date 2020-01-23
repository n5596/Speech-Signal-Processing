clc;
close all;
clear all;

filename = 'arctic_a0001.wav';
[data, srate] = audioread(filename);
% sound(data, srate);

cropped_data = data(1:32000, 1);
cropped_truth = data(1:32000, 2);

info = audioinfo(filename);

autocorrelation = zeros(size(cropped_data, 1), 1);
m = 1;

duration = 20/1000;
samples = duration * info.SampleRate;
for i = m+1:size(cropped_data, 1)
    s1 = data(i:i+samples-1, 1);
    s2 = data(i-m:i+samples-1-m, 1);
    n1 = s1 .* s2;
    num = sum(n1(:));
    ss1 = s1 .^2;
    ss2 = s2 .^2;
    d1 = sum(ss1(:));
    d2 = sum(ss2(:));
    denom = sqrt(d1*d2);
    autocorrelation(i) = num/denom;
end

t = 0:size(cropped_data, 1)-1;
plot(t, autocorrelation, 'DisplayName', 'normalized ac coeff');
hold on;
legend('-DynamicLegend');
plot(t, cropped_truth, 'DisplayName', 'ground truth');
hold on;
plot(t, cropped_data, 'DisplayName', 'speech');
btitle('Normalized autocorrelation coeff');