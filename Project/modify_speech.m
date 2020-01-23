function new_speech = modify_speech(O, speech1, srate1)
    new_speech = zeros(size(speech1,1),1);
    start = 1;
    for i = 1:size(O,1)
        part = O{i,1};
        finish = start+size(part,1)-1;
        new_speech(start:finish,:) = part(:);
        start = finish+1;
    end
%     for i = 1:size(new_speech,1)
%         if new_speech(i)==0
%             new_speech(i) = speech1(i,2);
%         end
%     end
end