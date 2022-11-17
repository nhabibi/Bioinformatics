function [ mono_peptide_freq_s ] = Mono_Peptide_Freq( protein_sequence_s )
%-------------------------------------------------------------------------
    %1.A   %2.C   %3.D   %4.E   %5.F   %6.G   %7.H   %8.I   %9.K   
    %10.L  %11.M  %12.N  %13.P  %14.Q  %15.R  %16.S  %17.T  %18.U 
    %19.V  %20.W  %21.Y  %22.Other 
    
    number_of_proteins = size( protein_sequence_s,1);
    
    mono_peptide_freq_s = zeros(number_of_proteins,22);
    
    for i=1:number_of_proteins
            
         protein = protein_sequence_s{i};
         protein_length = length(protein);
         
         for j=1:protein_length 
             
             AA = AAtoCode( protein(j) );
             mono_peptide_freq_s(i,AA) = mono_peptide_freq_s(i,AA) + 1;  
             
         end 
         
         mono_peptide_freq_s(i,:) = mono_peptide_freq_s(i,:)/protein_length;

    end
%--------------------------------------------------------------------------    
end

