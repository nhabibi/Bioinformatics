function [ mf,f ] = ModeStr( x,e )
%--------------------------------------------------------------------------
    %MODECHAR Summary of this function goes here
    %   Detailed explanation goes here

    y = unique(x);

    % n = histc(x,y); % Use the unique values as edges

    n=zeros(length(y),1);
    for i=1:length(y)
        if ~strcmp(y(i),e)
            cnt=0;
            for j=1:length(x)
                if strcmp(y(i),x(j))
                    cnt=cnt+1;
                end
            end
            n(i)=cnt;
        end
    end

    [f,i] = max(n);
    mf = y(i); 
    
%--------------------------------------------------------------------------    
end

