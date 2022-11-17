function [ gene_3Mer_s ] = Gene_3_Mer( gene_sequence_s )
%--------------------------------------------------------------------------
     
    %AAA,AAC,AAG,AAT,ACA,ACC,ACG,ACT,AGA,AGC,AGG,AGT,ATA,ATC,ATG,ATT
    %CAA,CAC,CAG,CAT,CCA,CCC,CCG,CCT,CGA,CGC,CGG,CGT,CTA,CTC,CTG,CTT
    %GAA,GAC,GAG,GAT,GCA,GCC,GCG,GCT,GGA,GGC,GGG,GGT,GTA,GTC,GTG,GTT
    %TAA,TAC,TAG,TAT,TCA,TCC,TCG,TCT,TGA,TGC,TGG,TGT,TTA,TTC,TTG,TTT
    
    number_of_genes = size(gene_sequence_s,1);
    
    gene_3Mer_s = zeros( number_of_genes , 64);  

    for i=1:number_of_genes
        temp3Mer = nmercount(gene_sequence_s{i}, 3);
        for j=1:size(temp3Mer,1)
            if strcmp(temp3Mer{j,1},'AAA')
                gene_3Mer_s(i,1)=temp3Mer{j,2};
            elseif strcmp(temp3Mer{j,1},'AAC')
                gene_3Mer_s(i,2)=temp3Mer{j,2};
            elseif strcmp(temp3Mer{j,1},'AAG')
                gene_3Mer_s(i,3)=temp3Mer{j,2};    
            elseif strcmp(temp3Mer{j,1},'AAT')
                gene_3Mer_s(i,4)=temp3Mer{j,2};  
            elseif strcmp(temp3Mer{j,1},'ACA')
                gene_3Mer_s(i,5)=temp3Mer{j,2};
            elseif strcmp(temp3Mer{j,1},'ACC')
                gene_3Mer_s(i,6)=temp3Mer{j,2};
            elseif strcmp(temp3Mer{j,1},'ACG')
                gene_3Mer_s(i,7)=temp3Mer{j,2};    
            elseif strcmp(temp3Mer{j,1},'ACT')
                gene_3Mer_s(i,8)=temp3Mer{j,2};  
            elseif strcmp(temp3Mer{j,1},'AGA')
                gene_3Mer_s(i,9)=temp3Mer{j,2};
            elseif strcmp(temp3Mer{j,1},'AGC')
                gene_3Mer_s(i,10)=temp3Mer{j,2};
            elseif strcmp(temp3Mer{j,1},'AGG')
                gene_3Mer_s(i,11)=temp3Mer{j,2};    
            elseif strcmp(temp3Mer{j,1},'AGT')
                gene_3Mer_s(i,12)=temp3Mer{j,2}; 
            elseif strcmp(temp3Mer{j,1},'ATA')
                gene_3Mer_s(i,13)=temp3Mer{j,2};
            elseif strcmp(temp3Mer{j,1},'ATC')
                gene_3Mer_s(i,14)=temp3Mer{j,2};
            elseif strcmp(temp3Mer{j,1},'ATG')
                gene_3Mer_s(i,15)=temp3Mer{j,2};    
            elseif strcmp(temp3Mer{j,1},'ATT')
                gene_3Mer_s(i,16)=temp3Mer{j,2}; 
            elseif strcmp(temp3Mer{j,1},'CAA')
                gene_3Mer_s(i,17)=temp3Mer{j,2};
            elseif strcmp(temp3Mer{j,1},'CAC')
                gene_3Mer_s(i,18)=temp3Mer{j,2};
            elseif strcmp(temp3Mer{j,1},'CAG')
                gene_3Mer_s(i,19)=temp3Mer{j,2};    
            elseif strcmp(temp3Mer{j,1},'CAT')
                gene_3Mer_s(i,20)=temp3Mer{j,2};  
            elseif strcmp(temp3Mer{j,1},'CCA')
                gene_3Mer_s(i,21)=temp3Mer{j,2};
            elseif strcmp(temp3Mer{j,1},'CCC')
                gene_3Mer_s(i,22)=temp3Mer{j,2};
            elseif strcmp(temp3Mer{j,1},'CCG')
                gene_3Mer_s(i,23)=temp3Mer{j,2};    
            elseif strcmp(temp3Mer{j,1},'CCT')
                gene_3Mer_s(i,24)=temp3Mer{j,2};  
            elseif strcmp(temp3Mer{j,1},'CGA')
                gene_3Mer_s(i,25)=temp3Mer{j,2};
            elseif strcmp(temp3Mer{j,1},'CGC')
                gene_3Mer_s(i,26)=temp3Mer{j,2};
            elseif strcmp(temp3Mer{j,1},'CGG')
                gene_3Mer_s(i,27)=temp3Mer{j,2};    
            elseif strcmp(temp3Mer{j,1},'CGT')
                gene_3Mer_s(i,28)=temp3Mer{j,2}; 
            elseif strcmp(temp3Mer{j,1},'CTA')
                gene_3Mer_s(i,29)=temp3Mer{j,2};
            elseif strcmp(temp3Mer{j,1},'CTC')
                gene_3Mer_s(i,30)=temp3Mer{j,2};
            elseif strcmp(temp3Mer{j,1},'CTG')
                gene_3Mer_s(i,31)=temp3Mer{j,2};    
            elseif strcmp(temp3Mer{j,1},'CTT')
                gene_3Mer_s(i,32)=temp3Mer{j,2}; 
            elseif strcmp(temp3Mer{j,1},'GAA')
                gene_3Mer_s(i,33)=temp3Mer{j,2};
            elseif strcmp(temp3Mer{j,1},'GAC')
                gene_3Mer_s(i,34)=temp3Mer{j,2};
            elseif strcmp(temp3Mer{j,1},'GAG')
                gene_3Mer_s(i,35)=temp3Mer{j,2};    
            elseif strcmp(temp3Mer{j,1},'GAT')
                gene_3Mer_s(i,36)=temp3Mer{j,2};  
            elseif strcmp(temp3Mer{j,1},'GCA')
                gene_3Mer_s(i,37)=temp3Mer{j,2};
            elseif strcmp(temp3Mer{j,1},'GCC')
                gene_3Mer_s(i,38)=temp3Mer{j,2};
            elseif strcmp(temp3Mer{j,1},'GCG')
                gene_3Mer_s(i,39)=temp3Mer{j,2};    
            elseif strcmp(temp3Mer{j,1},'GCT')
                gene_3Mer_s(i,40)=temp3Mer{j,2};  
            elseif strcmp(temp3Mer{j,1},'GGA')
                gene_3Mer_s(i,41)=temp3Mer{j,2};
            elseif strcmp(temp3Mer{j,1},'GGC')
                gene_3Mer_s(i,42)=temp3Mer{j,2};
            elseif strcmp(temp3Mer{j,1},'GGG')
                gene_3Mer_s(i,43)=temp3Mer{j,2};    
            elseif strcmp(temp3Mer{j,1},'GGT')
                gene_3Mer_s(i,44)=temp3Mer{j,2}; 
            elseif strcmp(temp3Mer{j,1},'GTA')
                gene_3Mer_s(i,45)=temp3Mer{j,2};
            elseif strcmp(temp3Mer{j,1},'GTC')
                gene_3Mer_s(i,46)=temp3Mer{j,2};
            elseif strcmp(temp3Mer{j,1},'GTG')
                gene_3Mer_s(i,47)=temp3Mer{j,2};    
            elseif strcmp(temp3Mer{j,1},'GTT')
                gene_3Mer_s(i,48)=temp3Mer{j,2}; 
            elseif strcmp(temp3Mer{j,1},'TAA')
                gene_3Mer_s(i,49)=temp3Mer{j,2};
            elseif strcmp(temp3Mer{j,1},'TAC')
                gene_3Mer_s(i,50)=temp3Mer{j,2};
            elseif strcmp(temp3Mer{j,1},'TAG')
                gene_3Mer_s(i,51)=temp3Mer{j,2};    
            elseif strcmp(temp3Mer{j,1},'TAT')
                gene_3Mer_s(i,52)=temp3Mer{j,2};  
            elseif strcmp(temp3Mer{j,1},'TCA')
                gene_3Mer_s(i,53)=temp3Mer{j,2};
            elseif strcmp(temp3Mer{j,1},'TCC')
                gene_3Mer_s(i,54)=temp3Mer{j,2};
            elseif strcmp(temp3Mer{j,1},'TCG')
                gene_3Mer_s(i,55)=temp3Mer{j,2};    
            elseif strcmp(temp3Mer{j,1},'TCT')
                gene_3Mer_s(i,56)=temp3Mer{j,2};  
            elseif strcmp(temp3Mer{j,1},'TGA')
                gene_3Mer_s(i,57)=temp3Mer{j,2};
            elseif strcmp(temp3Mer{j,1},'TGC')
                gene_3Mer_s(i,58)=temp3Mer{j,2};
            elseif strcmp(temp3Mer{j,1},'TGG')
                gene_3Mer_s(i,59)=temp3Mer{j,2};    
            elseif strcmp(temp3Mer{j,1},'TGT')
                gene_3Mer_s(i,60)=temp3Mer{j,2}; 
            elseif strcmp(temp3Mer{j,1},'TTA')
                gene_3Mer_s(i,61)=temp3Mer{j,2};
            elseif strcmp(temp3Mer{j,1},'TTC')
                gene_3Mer_s(i,62)=temp3Mer{j,2};
            elseif strcmp(temp3Mer{j,1},'TTG')
                gene_3Mer_s(i,63)=temp3Mer{j,2};    
            elseif strcmp(temp3Mer{j,1},'TTT')
                gene_3Mer_s(i,64)=temp3Mer{j,2}; 
            end
        end
    end
    
    
%--------------------------------------------------------------------------
end

