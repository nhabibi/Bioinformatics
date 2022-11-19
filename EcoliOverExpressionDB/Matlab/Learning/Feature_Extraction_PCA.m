function [ pca_data ] = Feature_Extraction_PCA( data_no_class )
%--------------------------------------------------------------------------
    %Preserve only significantly contributing original features in affine
    %projection (by default preserving features contributing 95% of total):
    %p = sdpca(data,0.99)
   
    %http://www.mathworks.com/help/stats/princomp.html
    %----------------------------------------------------------------------
    %It seems that in the new space, the columns beyond the size(data_no_class,1)
    %are zero.
    
    [~, score] = princomp(data_no_class);
    pca_data = score( :, 1 : size(data_no_class,1)-1 );
    %pca_data = score;
    
%--------------------------------------------------------------------------
end

