clc;
close all;
clear all;

folder = '~/7thSem/SSP/Assignment2_Wavfiles/';
listing = dir(folder);

n = size(listing,1);
irate = zeros(n, 1);
mrate = zeros(n, 1);

for i = 3:n
    audioname = listing(i).name;
    filename = strcat(folder,audioname);
    [data, srate] = audioread(filename);
    info = audioinfo(filename);
    speech = data(:,1);
    ground_truth = data(:,2);
    [e,d,idr,mr] = performance(speech, ground_truth, info);
%     disp([i idr mr]);
    irate(i) = idr;
    mrate(i) = mr;
end
disp('Mean identification rate');
disp(mean(irate(:)));
disp('Mean miss rate');
disp(mean(mrate(:)));