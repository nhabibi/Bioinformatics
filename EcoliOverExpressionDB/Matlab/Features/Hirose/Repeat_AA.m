function [ repeat_AA_s ] = Repeat_AA( protein_sequence_s )
%--------------------------------------------------------------------------
%Repeat: maximum number of consecutive same amino acids

number_of_proteins = size(protein_sequence_s,1);

repeat_AA_s = zeros(number_of_proteins,22);

for i=1:number_of_proteins
    
    for j=1:22
        
        repeat_AA_s(i,j) = Repeat( protein_sequence_s{i} , CodetoAA(j) );
        
    end
    
end


%--------------------------------------------------------------------------
end

