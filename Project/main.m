clc;
close all;
clear all;

filename2 = 'arctic_a0054.wav';  % the signal whose accent we want to convert
filename1 = 'arctic_a0054_avani.wav'; % the reference signal. foreign speech
t2 = importdata('arctic_a0054.lab');
t1 = importdata('arctic_a0054_avani.lab');

T1 = load_transcriptions(t1);
% T2 = load_transcriptions(t2);
[speech1, srate1] = audioread(filename1);
[speech2, srate2] = audioread(filename2);
pitch_val = load('value.mat');
% pitch_val2 = load('value2.mat');
% pitch = cell(2,1);
% pitch{1,1} = pitch_val2.x(:,1);
% pitch{2,1} = pitch_val1.x(:,2);

% S1 = split_speech(speech1, T1, srate1);
% S2 = split_speech(speech2, T2, srate2);

[S1, S2] = get_splits(T1);
V = find_voiced_words(S1, S2, srate1, srate2);
[E1, E2] = find_energy_words(S1, S2, srate1, srate2);
O = change_energy_words(S1, S2, E1, E2, V, srate1, srate2);
P = change_pitch_words(O,pitch_val.p);
new_speech_with = modify_speech(P,speech1);
new_speech_without = modify_speech(S2,speech1);
% orig = modify_speech(S1,speech1);