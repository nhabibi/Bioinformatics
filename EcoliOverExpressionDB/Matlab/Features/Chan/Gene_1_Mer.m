function [ gene_1Mer_s ] = Gene_1_Mer( gene_sequence_s )
%--------------------------------------------------------------------------
 %A,C,G,T
 
 number_of_genes = size(gene_sequence_s,1);
 
 gene_1Mer_s = zeros( number_of_genes , 4);
 
 for i=1:number_of_genes
        temp1Mer = nmercount(gene_sequence_s{i}, 1);
        for j=1:size(temp1Mer,1)
            if temp1Mer{j,1} == 'A'
                gene_1Mer_s(i,1)=temp1Mer{j,2};
            elseif temp1Mer{j,1}=='C'
                gene_1Mer_s(i,2)=temp1Mer{j,2};
            elseif temp1Mer{j,1}=='G'
                gene_1Mer_s(i,3)=temp1Mer{j,2};    
            elseif temp1Mer{j,1}=='T'
                gene_1Mer_s(i,4)=temp1Mer{j,2};            
            end
        end
  end

%--------------------------------------------------------------------------
end

