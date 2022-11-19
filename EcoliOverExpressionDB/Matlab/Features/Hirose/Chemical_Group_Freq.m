function [ chemical_s ] = Chemical_Group_Freq( mono_peptide_freq_s )
%--------------------------------------------------------------------------

% Frequencies of chemical property groups (8 groups)
% 1-Aliphatic: [GALVI] 
% 2-Aromatic: [FYW]
% 3-Hydroxyl: [ST]
% 4-Acidic: [DE]
% 5-Amide: [NQ] 
% 6-Basic: [RHK]
% 7-Sulfur: [CM]
% 8-Ring: [P]

number_of_proteins = size(mono_peptide_freq_s,1);

chemical_s = zeros(number_of_proteins,8);

for i=1:number_of_proteins
    
    chemical_s(i,1) = mono_peptide_freq_s(i,AAtoCode('G'))+...
                      mono_peptide_freq_s(i,AAtoCode('A'))+...
                      mono_peptide_freq_s(i,AAtoCode('L'))+...
                      mono_peptide_freq_s(i,AAtoCode('V'))+...
                      mono_peptide_freq_s(i,AAtoCode('I'));
                       
    chemical_s(i,2) = mono_peptide_freq_s(i,AAtoCode('F'))+...
                      mono_peptide_freq_s(i,AAtoCode('Y'))+...
                      mono_peptide_freq_s(i,AAtoCode('W'));
                       
    chemical_s(i,3) = mono_peptide_freq_s(i,AAtoCode('S'))+...
                      mono_peptide_freq_s(i,AAtoCode('T'));
                           
    chemical_s(i,4) = mono_peptide_freq_s(i,AAtoCode('D'))+...
                      mono_peptide_freq_s(i,AAtoCode('E'));
                           
    chemical_s(i,5) = mono_peptide_freq_s(i,AAtoCode('N'))+...
                      mono_peptide_freq_s(i,AAtoCode('Q'));
                           
    chemical_s(i,6) = mono_peptide_freq_s(i,AAtoCode('R'))+...
                      mono_peptide_freq_s(i,AAtoCode('H'))+...
                      mono_peptide_freq_s(i,AAtoCode('K'));
                       
    chemical_s(i,7) = mono_peptide_freq_s(i,AAtoCode('C'))+...
                      mono_peptide_freq_s(i,AAtoCode('M'));
                           
    chemical_s(i,8) = mono_peptide_freq_s(i,AAtoCode('P'));
                           
end

%--------------------------------------------------------------------------
end

