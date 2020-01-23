function T = load_transcriptions(t)
    T = cell(size(t,1),3);
    for i = 1:size(t,1)
        s = t{i,1};
        words = strsplit(s);
        T{i,1} = words{1,1};
        T{i,2} = words{1,2};
        T{i,3} = words{1,3};
    end
end