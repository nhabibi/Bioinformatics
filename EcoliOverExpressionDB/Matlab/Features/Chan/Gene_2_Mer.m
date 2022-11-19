function [ gene_2Mer_s ] = Gene_2_Mer( gene_sequence_s )
%--------------------------------------------------------------------------

%AA,AC,AG,AT,CA,CC,CG,CT,GA,GC,GG,GT,TA,TC,TG,TT

  number_of_genes = size(gene_sequence_s,1);

  gene_2Mer_s = zeros( number_of_genes , 16);
  
  for i=1:number_of_genes
 
        temp2Mer = nmercount(gene_sequence_s{i}, 2);
        for j=1:size(temp2Mer,1)
            if strcmp(temp2Mer{j,1},'AA')
                gene_2Mer_s(i,1)=temp2Mer{j,2};
            elseif strcmp(temp2Mer{j,1},'AC')
                gene_2Mer_s(i,2)=temp2Mer{j,2};
            elseif strcmp(temp2Mer{j,1},'AG')
                gene_2Mer_s(i,3)=temp2Mer{j,2};    
            elseif strcmp(temp2Mer{j,1},'AT')
                gene_2Mer_s(i,4)=temp2Mer{j,2};  
            elseif strcmp(temp2Mer{j,1},'CA')
                gene_2Mer_s(i,5)=temp2Mer{j,2};
            elseif strcmp(temp2Mer{j,1},'CC')
                gene_2Mer_s(i,6)=temp2Mer{j,2};
            elseif strcmp(temp2Mer{j,1},'CG')
                gene_2Mer_s(i,7)=temp2Mer{j,2};    
            elseif strcmp(temp2Mer{j,1},'CT')
                gene_2Mer_s(i,8)=temp2Mer{j,2};  
            elseif strcmp(temp2Mer{j,1},'GA')
                gene_2Mer_s(i,9)=temp2Mer{j,2};
            elseif strcmp(temp2Mer{j,1},'GC')
                gene_2Mer_s(i,10)=temp2Mer{j,2};
            elseif strcmp(temp2Mer{j,1},'GG')
                gene_2Mer_s(i,11)=temp2Mer{j,2};    
            elseif strcmp(temp2Mer{j,1},'GT')
                gene_2Mer_s(i,12)=temp2Mer{j,2}; 
            elseif strcmp(temp2Mer{j,1},'TA')
                gene_2Mer_s(i,13)=temp2Mer{j,2};
            elseif strcmp(temp2Mer{j,1},'TC')
                gene_2Mer_s(i,14)=temp2Mer{j,2};
            elseif strcmp(temp2Mer{j,1},'TG')
                gene_2Mer_s(i,15)=temp2Mer{j,2};    
            elseif strcmp(temp2Mer{j,1},'TT')
                gene_2Mer_s(i,16)=temp2Mer{j,2}; 
            end
        end
    end    
    

%--------------------------------------------------------------------------
end

%seq='ATGGATTTATCATCACCTCAAACGAGATATATCCCGGATGAGGCTGACTTTCTGCTGGGGATGGCCACTGTGAATAACTGTGTTTCCTACCGAAACCCTGCAGAGGGAACCTGGTACATCCAGTCACTTTGCCAGAGCCTGAGAGAGCGATGTCCTCGAGGCGATGATATTCTCACCATCCTGACTGAAGTGAACTATGAAGTAAGCAACAAGGATGACAAGAAAAACATGGGGAAACAGATGCCTCAGCCTACTTTCACACTAAGAAAAAAACTTGTCTTCCCTTCTGATTGA'