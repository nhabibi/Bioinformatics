function [ protein_sequence_s, wrong_gene_s ] = Translate_Gene( gene_sequence_s )
%--------------------------------------------------------------------------
%Convert nucleotide sequence to amino acid sequence
    
    number_of_genes = size(gene_sequence_s,1);
    counter = 0;
    
    for i=1:number_of_genes
        
        gene = gene_sequence_s{i,1};
        protein = nt2aa(gene, 'ACGTOnly',true);
        gene_length = length(gene);
        protein_length = length(protein);
        
        protein_sequence_s{i,1} = protein;
        
        length_is_OK = (protein_length == gene_length/3) ;
          
        has_at_most_one_stop_at_end = isempty(strfind( protein(1:protein_length-1) , '*'));
                                       
        
        if ( ~length_is_OK || ~has_at_most_one_stop_at_end )
                              
               [frame ORF] = Find_Frame_And_ORF(gene);
               protein_sequence_s{i,1} =  nt2aa(ORF, 'ACGTOnly',true);
               
               counter = counter+1;
               wrong_gene_s(counter,1) = i;
               wrong_gene_s(counter,2) = length_is_OK;
               wrong_gene_s(counter,3) = has_at_most_one_stop_at_end;
               wrong_gene_s(counter,4) = frame;
               
        end 
        
   end
    
%--------------------------------------------------------------------------
end

