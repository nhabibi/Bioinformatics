function [ data_num ] = ReplaceByNumericalValue( data , codes)
%--------------------------------------------------------------------------
    data_num = zeros(length(data),1);

    for idx=1:length(data)
        
        found = 0;
        cnt = 1;
        while (found == 0) && ( cnt<=length(codes) )
                        
            if ( strcmp(codes(cnt) , data(idx)) == 1 )
                found = 1;
                data_num(idx) = cnt;
            end
            
            cnt = cnt+1 ;
        end
        
        if (found == 0)
            sprintf('Could not find in codes=%s at position=%d', data(idx) , idx )
        end
        
    end
%--------------------------------------------------------------------------        
end