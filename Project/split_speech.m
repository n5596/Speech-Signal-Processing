function S = split_speech(speech, T, srate)
    S = cell(size(T,1),1);
    for i = 1:size(T,1)
        start = str2double(T{i,1});
        finish = str2double(T{i,2});
        s1 = round(start*srate);
        s2 = round(finish*srate);
        if s1==0
            s1 = 1;
        end
        if s2 > size(speech,1)
            s2 = size(speech,1);
        end
        extracted = speech(s1:s2,:);
%         sound(extracted,srate);
%         sound(speech,srate);
        S{i,1} = extracted(:,:);
    end
end