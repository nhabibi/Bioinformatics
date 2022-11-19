function [ ASA_physical_s ] = ASA_Physical_Group( ASA_aa_s )
%--------------------------------------------------------------------------
% Frequencies of physical property groups in surface area
% -Nonpolar & hydrophilic: [GAVLIP]
% -Polar & noncharged: [FWY]
% -Polar & charged:
% [STCMNQ]
% -Negative charge:
% [DE]
% -Positive charge:
% [RKH]

number_of_proteins = size(ASA_aa_s,1);

ASA_physical_s = zeros(number_of_proteins,5);

for i=1:number_of_proteins
    
    ASA_physical_s(i,1) =ASA_aa_s(i,AAtoCode('G'))+...
                         ASA_aa_s(i,AAtoCode('A'))+...
                         ASA_aa_s(i,AAtoCode('V'))+...
                         ASA_aa_s(i,AAtoCode('L'))+...
                         ASA_aa_s(i,AAtoCode('I'))+...
                         ASA_aa_s(i,AAtoCode('P'));
                       
    ASA_physical_s(i,2) =ASA_aa_s(i,AAtoCode('F'))+...
                         ASA_aa_s(i,AAtoCode('W'))+...
                         ASA_aa_s(i,AAtoCode('Y'));
                       
    ASA_physical_s(i,3) =ASA_aa_s(i,AAtoCode('S'))+...
                         ASA_aa_s(i,AAtoCode('T'))+...
                         ASA_aa_s(i,AAtoCode('C'))+...
                         ASA_aa_s(i,AAtoCode('M'))+...
                         ASA_aa_s(i,AAtoCode('N'))+...
                         ASA_aa_s(i,AAtoCode('Q'));
                           
    ASA_physical_s(i,4) =ASA_aa_s(i,AAtoCode('D'))+...
                         ASA_aa_s(i,AAtoCode('E'));
                           
    ASA_physical_s(i,5) =ASA_aa_s(i,AAtoCode('R'))+...
                         ASA_aa_s(i,AAtoCode('K'))+...
                         ASA_aa_s(i,AAtoCode('H'));
end

%--------------------------------------------------------------------------
end
