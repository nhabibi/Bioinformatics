function [ repeat ] = Repeat( str , ch )
%This function returns the maximum number of consecutive same ch in str.

    pattern = strcat('[' , ch , ']+');

    hits = regexp(str, pattern, 'match');

    if isempty(hits)
        repeat = 0;
    else
        length_hits = cellfun('length',hits);
        repeat = max(length_hits);
    end

end

