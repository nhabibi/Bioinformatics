
function [ N_term_s , C_term_s ] = Terminal_Proteins( sequence_s )
%--------------------------------------------------------------------------
   length_term = 20;
   
   number_of_sequences = size(sequence_s,1);
     
   for i=1:number_of_sequences
       
       seq = sequence_s{i};
       seq_length = length(seq);
       
       if(seq_length > length_term)
           N_term_s{i,1} = seq(1 : length_term);
           C_term_s{i,1} = seq(seq_length-length_term+1 : seq_length);
       else
           %i
           length_term = seq_length-1;
           N_term_s{i,1} = seq(1 : length_term);
           C_term_s{i,1} = seq(seq_length-length_term+1 : seq_length);
      end
       
   end
%--------------------------------------------------------------------------
end

