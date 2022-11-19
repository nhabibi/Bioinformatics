function [ avg_result , mat_srucut ] = Average_Result( result )
%--------------------------------------------------------------------------

    for i=1:size(result,1)
        
        next_srucut = result(i,1);
        
        cell_srucut = struct2cell(next_srucut);
        mat_srucut(i,:)  = cell2mat(cell_srucut);

    end
    
    if( size(mat_srucut,1) > 1 )
            avg_result = nanmean(mat_srucut);
    else
        avg_result = mat_srucut;
    end
 
%--------------------------------------------------------------------------
end

