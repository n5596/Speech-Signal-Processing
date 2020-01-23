function output = change_energy(speech1, speech2, energy1, energy2, voiced, srate1, srate2)
    output = zeros(size(speech2,1),1);
    for i = 1:size(voiced,1)
       factor = 1;
       if voiced(i,1:2) == [0 0] 
          break; 
       end
       if voiced(i,3:4) == [0 0]
           break;
       end
%        e1 = energy1(voiced(i,1):voiced(i,2));
%        e2 = energy2(voiced(i,3):voiced(i,4));
       
       e1 = energy1;
       e2 = energy2;
       
       factor = mean(e1(:))/mean(e2(:));
%        sig2 = speech2;
%        output = sig2*sqrt(factor);
       sig2 = speech2(voiced(i,3):voiced(i,4),1);
       output(voiced(i,3):voiced(i,4)) = sqrt(factor) * sig2;
    end
end