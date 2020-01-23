clc;
close all;
clear all;

filename = 'arctic_a0001.wav';
[data, srate] = audioread(filename);
% sound(data, srate);

cropped_data = data(1:32000, 1);
cropped_truth = data(1:32000, 2);

info = audioinfo(filename);

energy = zeros(size(cropped_data, 1), 1);

duration = 20/1000;
samples = duration * info.SampleRate;
for i = 1:size(cropped_data, 1)
    signal = data(i:i+samples-1, 1);
    esq = signal.^2;
    energy(i) = (sum(esq(:))); %do it with log and without log
end

t = 0:size(cropped_data, 1)-1;
plot(t, (energy), 'DisplayName', 'energy');
legend('-DynamicLegend');
hold on;
plot(t, cropped_truth, 'DisplayName', 'ground truth');
hold on; 
title('Energy');
plot(t, cropped_data, 'DisplayName', 'speech');