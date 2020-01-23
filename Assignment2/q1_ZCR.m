clc;
close all;
clear all;

filename = 'arctic_a0001.wav';
[data, srate] = audioread(filename);
% sound(data, srate);

cropped_data = data(1:32000, 1);
cropped_truth = data(1:32000, 2);

info = audioinfo(filename);

zcr = zeros(size(cropped_data, 1), 1);

duration = 20/1000;
samples = duration * info.SampleRate;

for i = 1:size(cropped_data, 1)
    signal = data(i:i+samples-1, 1);
    s_size = size(signal, 1);
    count = 0;
    for j = 1:s_size
        if (j~= s_size && signal(j)*signal(j+1)<=0)
               count = count+1;
        end
    end
    zcr(i) = count;
end

t = 0:size(cropped_data, 1)-1;
plot(t, log(zcr), 'DisplayName', 'zcr');
hold on;
legend('-DynamicLegend');
plot(t, cropped_truth, 'DisplayName', 'ground truth');
hold on;
plot(t, cropped_data, 'DisplayName', 'speech');