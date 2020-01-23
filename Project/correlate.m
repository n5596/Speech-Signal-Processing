clc;
close all;
clear all;

o_pitch = load('arctic_a0054_pitch.f0');
n_pitch = load('arctic_a0054_naila_pitch.f0');
im_n_pitch = load('im_arctic_a0054_naila_pitch.f0');

o_form = load('arctic_a0054_formant.frm');
n_form = load('arctic_a0054_naila_formant.frm');
im_n_form = load('im_arctic_a0054_naila_formant.frm');

o_p = reshape(o_pitch, [size(o_pitch,1)*size(o_pitch,2) 1]);
n_p = reshape(n_pitch, [size(n_pitch,1)*size(n_pitch,2) 1]);
im_n_p = reshape(im_n_pitch, [size(im_n_pitch,1)*size(im_n_pitch,2) 1]);

o_f = reshape(o_form, [size(o_form,1)*size(o_form,2) 1]);
n_f = reshape(n_form, [size(n_form,1)*size(n_form,2) 1]);
im_n_f = reshape(im_n_form, [size(im_n_form,1)*size(im_n_form,2) 1]);

p1 = xcorr(o_p, n_p);
f1 = xcorr(o_f, n_f);

p2 = xcorr(o_p, im_n_p);
f2 = xcorr(o_f, im_n_f);

figure, plot(p1); title('Pitch: original vs natural');
figure, plot(f1); title('Pitch: original vs imitated');
figure, plot(p2);title('Formant: original vs natural');
figure, plot(f2);title('Formant: original vs imitated');