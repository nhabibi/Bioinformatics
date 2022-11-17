function [ geneSeqFeatures ] = Generate_Gene_Seq_Features_Hirose()
%--------------------------------------------------------------------------   
 clc
 clear all
    
 fileName='D:\Dropbox\Thesis\Objective 2-Features Generation\Dataset_Hirose.xlsx';
 [~,~,raw] = xlsread(fileName,'Data');
   
 raw = raw( 2:size(raw,1) , : );
 geneSeqColumn  = 2;
        
 gene_sequence_s = raw( : , geneSeqColumn );
     
%--------------------------------------------------------------------------            
% number_of_genes = size(gene_sequence_s,1);
  
% [protein_sequence_s wrong_gene_s] = Translate_Gene(gene_sequence_s);
 
% xlswrite(fileName, protein_sequence_s, 'Data', strcat('F2:F',num2str(number_of_genes+1)) );

%--------------------------------------------------------------------------
 proteinColumnNumber = 6;
 protein_sequence_s = ( raw(:,proteinColumnNumber) );
 
%--------------------------------------------------------------------------  
  number_of_proteins = size(protein_sequence_s,1);
  
%--------------------------------------------------------------------------       
  %Length of protein
    
  size_of_polypeptide_s = zeros( number_of_proteins , 1);
  for i=1:number_of_proteins
        size_of_polypeptide_s(i) = length(protein_sequence_s{i});
  end           

%--------------------------------------------------------------------------           
  gene_3Mer_s = Gene_1_Mer(gene_sequence_s);
        
%--------------------------------------------------------------------------           
 mono_peptide_freq_s = Mono_Peptide_Freq(protein_sequence_s);
 chemical_freq_s = Chemical_Group_Freq(mono_peptide_freq_s);
 physical_freq_s = Physical_Group_Freq(mono_peptide_freq_s);
         
%--------------------------------------------------------------------------           
 repeat_AA_s = Repeat_AA(protein_sequence_s);
 repeat_chemical_s = Repeat_Chemical_Group(repeat_AA_s);
 repeat_physical_s = Repeat_Physical_Group(repeat_AA_s);
 
%--------------------------------------------------------------------------           
 ASAColumnNumber = 7;
 ASA_column = ( raw(:,ASAColumnNumber) );
 
 ASA_aa_s = ASA_AA(size_of_polypeptide_s , ASA_column);
 ASA_chemical_s = ASA_Chemical_Group(ASA_aa_s);
 ASA_physical_s = ASA_Physical_Group(ASA_aa_s);
 
%--------------------------------------------------------------------------           
transmembraneColumnNumber = 8;
transmembrane_column = ( raw(:,transmembraneColumnNumber) );

transmembrane_number_s = Transmembrane(transmembrane_column);

%--------------------------------------------------------------------------           
disorderedColumnNumber = 9;
disordered_column = ( raw(:,disorderedColumnNumber) );
    
[disordered_number_s, disordered_proportion_s] = Disorder(size_of_polypeptide_s, disordered_column);

%--------------------------------------------------------------------------           
 [N_term_gene_s , C_term_gene_s]       = Terminal_Genes(gene_sequence_s);
 [N_term_protein_s , C_term_protein_s] = Terminal_Proteins(protein_sequence_s);
 
 N_term_gene_3Mer_s = Gene_3_Mer( N_term_gene_s );
 C_term_gene_3Mer_s = Gene_3_Mer( C_term_gene_s );
 
 N_term_mono_peptide_freq_s = Mono_Peptide_Freq(N_term_protein_s);
 C_term_mono_peptide_freq_s = Mono_Peptide_Freq(C_term_protein_s);
 N_term_chemical_freq_s = Chemical_Group_Freq(N_term_mono_peptide_freq_s);
 C_term_chemical_freq_s = Chemical_Group_Freq(C_term_mono_peptide_freq_s);
 N_term_physical_freq_s = Physical_Group_Freq(N_term_mono_peptide_freq_s);
 C_term_physical_freq_s = Physical_Group_Freq(C_term_mono_peptide_freq_s);
 
 N_term_repeat_AA_s = Repeat_AA(N_term_protein_s);
 C_term_repeat_AA_s = Repeat_AA(C_term_protein_s);
 N_term_repeat_chemical_s = Repeat_Chemical_Group(N_term_repeat_AA_s);
 C_term_repeat_chemical_s = Repeat_Chemical_Group(C_term_repeat_AA_s);
 N_term_repeat_physical_s = Repeat_Physical_Group(N_term_repeat_AA_s);
 C_term_repeat_physical_s = Repeat_Physical_Group(C_term_repeat_AA_s);
 
 terminal_features = [ ...
     N_term_gene_3Mer_s, C_term_gene_3Mer_s, ...
     N_term_mono_peptide_freq_s, C_term_mono_peptide_freq_s, ...
     N_term_chemical_freq_s    , C_term_chemical_freq_s, ...
     N_term_physical_freq_s    , C_term_physical_freq_s, ...
     N_term_repeat_AA_s        , C_term_repeat_AA_s, ...
     N_term_repeat_chemical_s  , C_term_repeat_chemical_s, ...
     N_term_repeat_physical_s  , C_term_repeat_physical_s, ...
 ];

%--------------------------------------------------------------------------        

 geneSeqFeatures = [ ...
     size_of_polypeptide_s, ...    
     gene_3Mer_s, ...
     mono_peptide_freq_s, chemical_freq_s, physical_freq_s, ...
     repeat_AA_s, repeat_chemical_s, repeat_physical_s, ...
     ASA_aa_s, ASA_chemical_s, ASA_physical_s, ...
     transmembrane_number_s, ...
     disordered_number_s, disordered_proportion_s,...
     terminal_features ...
];

%--------------------------------------------------------------------------   
end

