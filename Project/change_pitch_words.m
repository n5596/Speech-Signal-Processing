function P = change_pitch_words(O,pitch_val)
    P = cell(size(O,1),2);
    for i = 1:size(O,1)
        speech = O{i,1};
%         [d,sr]=wavread('clar.wav');
        f0 = pitch_val(i,2);
        f1 = pitch_val(i,1);
        e = pvoc(speech, f0/f1);
        f = resample(e,5,5);    
%         soundsc(d(1:length(f))+f,sr) 
        P{i,1} = f;
    end
end