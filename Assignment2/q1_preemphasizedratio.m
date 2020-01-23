clc;
close all;
clear all;

filename = 'arctic_a0001.wav';
[data, srate] = audioread(filename);
% sound(data, srate);

cropped_data = data(1:32000, 1);
cropped_truth = data(1:32000, 2);

info = audioinfo(filename);

pr = zeros(size(cropped_data, 1), 1);

duration = 20/1000;
samples = duration * info.SampleRate;
for i = 2:size(cropped_data, 1)
    s1 = data(i:i+samples-1, 1);
    s2 = data(i-1:i+samples-1-1, 1);
    diff = abs(s1-s2);
    num = sum(diff(:));
    ss1 = s1 .^ 2;
    denom = sum(ss1(:));
    pr(i) = num/denom;
end

t = 0:size(cropped_data, 1)-1;
plot(t, log(pr), 'DisplayName', 'pr');
hold on;
legend('-DynamicLegend');
hold on;
plot(t, cropped_truth, 'DisplayName', 'ground truth');
hold on;
plot(t, cropped_data, 'DisplayName', 'speech');
title('pre emphasized energy ratio');