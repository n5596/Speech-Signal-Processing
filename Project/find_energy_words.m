function [E1, E2] = find_energy_words(S1, S2, srate1, srate2)
    E1 = cell(size(S1,1),1);
    E2 = cell(size(S1,1),1);
    for i = 1:size(E1,1)
        speech1 = S1{i,1};
        speech2 = S2{i,1};
        [energy1, energy2] = find_energy(speech1, speech2, srate1, srate2);
        E1{i,1} = energy1;
        E2{i,1} = energy2;
    end
end
