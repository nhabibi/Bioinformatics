function [ ASA_chemical_s ] = ASA_Chemical_Group( ASA_aa_s )
%--------------------------------------------------------------------------

% Frequencies of chemical property groups in surface area
% -Aliphatic: [GALVI] 
% -Aromatic: [FYW]
% -Hydroxyl: [ST]
% -Acidic: [DE]
% -Amide: [NQ] 
% -Basic: [RHK]
% -Sulfur: [CM]
% -Ring: [P]

 number_of_proteins = size(ASA_aa_s,1);

 ASA_chemical_s = zeros(number_of_proteins,8);
 
 for i=1:number_of_proteins
    
    ASA_chemical_s(i,1) = ASA_aa_s(i,AAtoCode('G'))+...
                          ASA_aa_s(i,AAtoCode('A'))+...
                          ASA_aa_s(i,AAtoCode('L'))+...
                          ASA_aa_s(i,AAtoCode('V'))+...
                          ASA_aa_s(i,AAtoCode('I'));
                       
    ASA_chemical_s(i,2) = ASA_aa_s(i,AAtoCode('F'))+...
                          ASA_aa_s(i,AAtoCode('Y'))+...
                          ASA_aa_s(i,AAtoCode('W'));
                       
    ASA_chemical_s(i,3) = ASA_aa_s(i,AAtoCode('S'))+...
                          ASA_aa_s(i,AAtoCode('T'));
                           
    ASA_chemical_s(i,4) = ASA_aa_s(i,AAtoCode('D'))+...
                          ASA_aa_s(i,AAtoCode('E'));
                           
    ASA_chemical_s(i,5) = ASA_aa_s(i,AAtoCode('N'))+...
                          ASA_aa_s(i,AAtoCode('Q'));
                           
    ASA_chemical_s(i,6) = ASA_aa_s(i,AAtoCode('R'))+...
                          ASA_aa_s(i,AAtoCode('H'))+...
                          ASA_aa_s(i,AAtoCode('K'));
                       
    ASA_chemical_s(i,7) = ASA_aa_s(i,AAtoCode('C'))+...
                          ASA_aa_s(i,AAtoCode('M'));
                           
    ASA_chemical_s(i,8) = ASA_aa_s(i,AAtoCode('P'));
                           
end


%--------------------------------------------------------------------------
end

