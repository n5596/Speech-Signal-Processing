function O = change_energy_words(S1, S2, E1, E2, V, srate1, srate2)
    O = cell(size(S1,1),1);
    for i = 1:size(S1,1)
        speech1 = S1{i,1};
        speech2 = S2{i,1};
        energy1 = E1{i,1};
        energy2 = E2{i,1};
        voiced = V{i,1};
        output = change_energy(speech1, speech2, energy1, energy2, voiced, srate1, srate2);
        O{i,1} = output;
    end
end