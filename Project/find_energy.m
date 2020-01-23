function [energy1, energy2] = find_energy(speech1, speech2, srate1, srate2)
    energy1 = zeros(size(speech1, 1), 1);
    energy2 = zeros(size(speech2, 1), 1);
    
    duration = 20/1000;
    samples = duration * srate1;
    for i = 1:size(speech1, 1)-samples+1
        signal = speech1(i:i+samples-1, 1);
        esq = signal.^2;
        energy1(i) = (sum(esq(:)));
    end
    
    samples = duration * srate2;
    for i = 1:size(speech2, 1)-samples
        signal = speech2(i:i+samples-1, 1);
        esq = signal.^2;
        energy2(i) = (sum(esq(:))); %do it with log and without log
    end
    
end