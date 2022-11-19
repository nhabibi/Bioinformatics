function [ ASA_aa_s ] = ASA_AA( size_of_polypeptide_s , ASA_column )
%--------------------------------------------------------------------------
%Frequencies of single amino acids in surface area
%The accessible surface area was predicted using RVPnet:http://rvp-net.netasa.org/

number_of_proteins = size(size_of_polypeptide_s,1);

ASA_aa_s = zeros(number_of_proteins,22);
     
 for i=1:number_of_proteins
         
         protein_length = size_of_polypeptide_s(i);
     
         str = ASA_column{i,1};

         start = strfind( str , 'Category');
         remain = str(start+7:end);
         
         for j=1:min(protein_length , 700) %Becuase the used application only accepts the sequences with maximum length=700. So we ignore the extra residues of such proteins! 
               
               [~, remain] = strtok(remain, ' '); %R. No.
               [AA, remain] = strtok(remain, ' '); %AA
               [~, remain] = strtok(remain, ' '); %ASA(%)
               [~, remain] = strtok(remain, ' '); %ASA(A^2)
               [status, remain] = strtok(remain, char(10)); %B or E
               %status
               if ( strcmp(status,'  E') )
                   %AA
                   ASA_aa_s( i , AAtoCode(AA) ) =  ASA_aa_s( i , AAtoCode(AA) ) + 1;
               end
         end
         
         ASA_aa_s(i,:) = ASA_aa_s(i,:) / protein_length;
 end
 
%--------------------------------------------------------------------------
end

