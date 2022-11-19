function [ geneSeqFeatures ] = Generate_Gene_Seq_Features_Chan()
%--------------------------------------------------------------------------   
    clc
    clear all
    
    fileName='D:\Dropbox\Thesis\Objective 2-Features Generation\Dataset_Chan.xlsx';
    [~,~,raw] = xlsread(fileName,'Data');
          
    raw = raw( 2:size(raw,1) , : );
    geneSeqColumn  = 2;
    
    gene_sequence_s = raw( : , geneSeqColumn );
    
%--------------------------------------------------------------------------
    number_of_genes = size(gene_sequence_s,1);

%--------------------------------------------------------------------------        
    %1. Nucleotide: <= 3-mer
    
    gene_1Mer_s = Gene_1_Mer(gene_sequence_s);
    gene_2Mer_s = Gene_2_Mer(gene_sequence_s);
    gene_3Mer_s = Gene_3_Mer(gene_sequence_s);
   
%-------------------------------------------------------------------------
    %2. Nucleotide: Sequence length
    
    gene_length_s = zeros( number_of_genes , 1);
    for i = 1:number_of_genes
        gene_length_s(i) = length(gene_sequence_s{i});
    end
%--------------------------------------------------------------------------   
    %3. Nucleotide: GC content
    
    GC_content_s = zeros(number_of_genes,1);
    for i=1:number_of_genes
        
        seqProperties = oligoprop(gene_sequence_s{i});
        GC_content_s(i) = seqProperties.GC;
    end
%--------------------------------------------------------------------------       
    %4.	Code Preference: Codon Adaptation Index
    %http://emboss.bioinformatics.nl/cgi-bin/emboss/cai
    %Codon Usage Table: Eecoli.cut
      
    CAIColumnNumber = 6;
       
    CAI_s = cell2mat( raw(:,CAIColumnNumber) );  
%--------------------------------------------------------------------------       
  
    geneSeqFeatures = [ ...
                       gene_1Mer_s , gene_2Mer_s , gene_3Mer_s , ...
                       gene_length_s , GC_content_s , CAI_s
    ];

%--------------------------------------------------------------------------   
end

