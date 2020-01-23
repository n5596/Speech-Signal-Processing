function V = find_voiced_words(S1, S2, srate1, srate2)
    V = cell(size(S1,1),1);
    for i = 1:size(V,1)
        speech1 = S1{i,1};
        speech2 = S2{i,1};
        voiced = find_voiced(speech1, speech2, srate1, srate2);
        V{i,1} = voiced;
    end
end
