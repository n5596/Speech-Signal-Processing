clc;
close all;
clear all;

filename = 'arctic_a0008.wav';
[data, srate] = audioread(filename);
info = audioinfo(filename);

speech = data(:,1);
ground_truth = data(:, 2);

n = size(speech, 1);
x = zeros(n, 1);
y1 = zeros(n, 1);
y2 = zeros(n, 1);
y = zeros(n, 1);
dzff = zeros(n, 1);
epochs = zeros(n, 1);
degg = zeros(n, 1);
u = zeros(n, 1);

x(1) = speech(1);
for i = 2:n
    x(i) = speech(i)-speech(i-1);
end

a1 = -2; a2 = 1;
for i = 1:n
    y1(i) = x(i);
    if i>1
    y1(i) = y1(i)-a1*y1(i-1);
    end
    if i>2
    y1(i) = y1(i)-a2*y1(i-2);
    end
end
for i = 1:n
    y2(i) = y1(i);
    if i>1
    y2(i) = y2(i)-a1*y2(i-1);
    end
    if i>2
    y2(i) = y2(i)-a2*y2(i-2);
    end
end

duration = 10/1000;
samples = round(duration * info.SampleRate);

for i = 1:n-samples+1
    v = y2(i:i+samples-1);
    s = sum(v(:));
    y(i) = y2(i) -s/samples;
end

zff = y2;
f1 = ones(samples,1);
for i = 1:4
    f2 = ones(size(zff,1), 1);
    c1 = conv(zff, f1);
    num= c1(samples/2:size(c1,1)-samples/2);
    c2 = conv(f1, f2);
    denom = c2(samples/2:size(c2,1)-samples/2);
    remove = num./denom;
    temp = zff-remove;
    zff = temp;
end
zff(n-samples*3:n) = 0;

for i = 1:size(zff,1)
    if zff(i,1)>0
        u(i) = 1;
    end
end

for i = 2:size(u, 1)
    dzff(i) = u(i) - u(i-1);
    if dzff(i) > 0
        epochs(i) = 1;
    else
        epochs(i) = 0;
    end
end

for i = 2:n
    degg(i) = ground_truth(i)-ground_truth(i-1);
end
t = 0:n-1;
plot(t, normalize(speech(:)), 'DisplayName', 'speech');
legend('-DynamicLegend');
hold on;
plot(t, normalize(zff(:)), 'DisplayName', 'zff');
hold on;
plot(t, epochs(:), 'DisplayName', 'epochs');
hold on;
plot(t, 30*degg(:), 'DisplayName', 'dEGG');