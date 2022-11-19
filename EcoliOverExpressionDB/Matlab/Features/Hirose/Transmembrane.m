function [ transmembrane_number_s ] = Transmembrane( transmembrane_column )
%--------------------------------------------------------------------------
%Number of transmembrane regions 
%Predicted by TMHMM: http://www.cbs.dtu.dk/services/TMHMM/

number_of_proteins = size(transmembrane_column,1);

transmembrane_number_s = zeros(number_of_proteins,1);
     
 for i=1:number_of_proteins
         
         str = transmembrane_column{i,1};

         start = strfind( str , 'PredHel=');
         remain = str(start+8:end);
         [number, ~] = strtok(remain, ' '); %Number 
         transmembrane_number_s(i) = str2num(number);
 end


%--------------------------------------------------------------------------
end

