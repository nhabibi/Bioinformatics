function [disordered_number_s,disordered_proportion_s,disordered_length_s] ...
 = Disorder( size_of_polypeptide_s , disordered_column )
%--------------------------------------------------------------------------

%Disordered regions
%Predicted by POODLE-L: http://mbs.cbrc.jp/poodle/poodle-l.html
%Help: http://mbs.cbrc.jp/poodle/help-l.html
%If disorder probability is greater than 0.5, the amino acid is predicted as disorder region
%Number of occurrence
%Length
%Proportion: Proportions in relation to the entire chain were computed.
 
number_of_proteins = size(size_of_polypeptide_s,1);

disordered_number_s     = zeros(number_of_proteins,1);
disordered_proportion_s = zeros(number_of_proteins,1);
disordered_length_s     = zeros(number_of_proteins,1);
     
 for i=1:number_of_proteins
         
         protein_length = size_of_polypeptide_s(i);
     
         str = disordered_column{i,1};

         start = strfind( str , 'Prob.');
         remain = str(start+4:end);
         
         for j=1:min(protein_length , 1000) %Becuase the used application only accepts sequences with maximum length=1000. So we ignore the extra residues of such proteins! 
                              
               [no, remain] = strtok(remain, ' '); %R. No.
               [AA, remain] = strtok(remain, ' '); %AA
               [status, remain] = strtok(remain,' '); %ORD/DIS:+1/-1
               [prob, remain] = strtok(remain, char(10)); %Prob.         
               
               if ( str2num(status)==1 )
                  disordered_number_s(i) = disordered_number_s(i) + 1; 
               end
         end
         
         disordered_proportion_s(i) = disordered_number_s(i) / protein_length;
 end


%--------------------------------------------------------------------------
end

