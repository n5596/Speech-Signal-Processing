clc;
close all;
clear all;

filename1 = 'voiced.wav';
[data, srate] = audioread(filename1);
info = audioinfo(filename1);
voiced = data(:,1);

filename2 = 'unvoiced.wav';
[data, srate] = audioread(filename2);
info = audioinfo(filename2);
unvoiced = data(:,1);

[coeffs, residual1] = lp_analysis(voiced, 8);
[coeffs, residual2] = lp_analysis(unvoiced, 8);

n1 = size(voiced, 1);
n2 = size(unvoiced, 1);

v_s = zeros(n1, 1);
v_r = zeros(n1, 1);
uv_s = zeros(n2, 1);
uv_r = zeros(n2, 1);

duration = 20/1000;
samples = duration * info.SampleRate;

n_v = zeros(5*samples, 1);
n_uv = zeros(5*samples, 1);

for i = 1:5*samples
    m1 = min(i+samples-1,n1);
    signal = voiced(i:m1, 1);
    esq = signal.^2;
    v_s(i) = (sum(esq(:))); 
    
    res = residual1(i:m1, 1);
    rsq = res.^2;
    v_r(i) = (sum(rsq(:)));
    
    n_v(i) = v_r(i)/v_s(i);
end

for i = 1:5*samples
    m2 = min(i+samples-1,n2);
    signal = unvoiced(i:m2, 1);
    esq = signal.^2;
    uv_s(i) = (sum(esq(:))); 
    
    res = residual1(i:m2, 1);
    rsq = res.^2;
    uv_r(i) = (sum(rsq(:)));
    
    n_uv(i) = uv_r(i)/uv_s(i);
end

t = 1:5*samples;
% plot(t, n_v, 'DisplayName', 'Voiced Normalized Error');
plot(t, unvoiced(1:5*samples), 'DisplayName','Unvoiced Segment');
legend('-DynamicLegend');
hold on;
% plot(t, voiced(1:5*samples), 'DisplayName', 'Voiced Segment');
plot(t, n_uv, 'DisplayName', 'Unvoiced Normalized Error');
% title('Normalizged error');