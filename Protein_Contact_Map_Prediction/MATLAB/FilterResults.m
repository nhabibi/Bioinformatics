function [ puredResult ] = FilterResults( result,PTMatrix )

    resultSize = size(result,2);
    for i=1:1:resultSize
        if result(1,i) == 1
            
           aai = PTMatrix(1,i);
           aaj = PTMatrix(2,i);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%           
           %charge     : negative=-1    neutral=0     positive=1
           switch aai
               case 1
                   chargei = 0;
               case 2
                   chargei = -1;        
               case 3
                   chargei = 0;
               case 4
                   chargei = 1;
               case 5
                   chargei = 0;
               case 6
                   chargei = 1;
               case 7
                   chargei = 0;
               case 8
                   chargei = 0;
               case 9
                   chargei = -1;
               case 10
                   chargei = 0;
               case 11
                   chargei = 0;
               case 12
                   chargei = -1;
               case 13
                   chargei = 0;
               case 14
                   chargei = 0;
               case 15
                   chargei = 0;
               case 16
                   chargei = 0;
               case 17
                   chargei = 0;
               case 18
                   chargei = 0;
               case 19
                   chargei = 0;
               case 20
                   chargei = 0;
           end
           
           switch aaj
               case 1
                   chargej = 0;
               case 2
                   chargej = -1;        
               case 3
                   chargej = 0;
               case 4
                   chargej = 1;
               case 5
                   chargej = 0;
               case 6
                   chargej = 1;
               case 7
                   chargej = 0;
               case 8
                   chargej = 0;
               case 9
                   chargej = -1;
               case 10
                   chargej = 0;
               case 11
                   chargej = 0;
               case 12
                   chargej = -1;
               case 13
                   chargej = 0;
               case 14
                   chargej = 0;
               case 15
                   chargej = 0;
               case 16
                   chargej = 0;
               case 17
                   chargej = 0;
               case 18
                   chargej = 0;
               case 19
                   chargej = 0;
               case 20
                   chargej = 0;
           end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%           
           %polarity     : polar=1        non-polar=0
%            switch aai
%                case 1
%                    polarityi = 0;
%                case 2
%                    polarityi = 1;        
%                case 3
%                    polarityi = 1;
%                case 4
%                    polarityi = 1;
%                case 5
%                    polarityi = 1;
%                case 6
%                    polarityi = 1;
%                case 7
%                    polarityi = 1;
%                case 8
%                    polarityi = 0;
%                case 9
%                    polarityi = 1;
%                case 10
%                    polarityi = 0;
%                case 11
%                    polarityi = 0;
%                case 12
%                    polarityi = 1;
%                case 13
%                    polarityi = 0;
%                case 14
%                    polarityi = 0;
%                case 15
%                    polarityi = 0;
%                case 16
%                    polarityi = 1;
%                case 17
%                    polarityi = 1;
%                case 18
%                    polarityi = 0;
%                case 19
%                    polarityi = 1;
%                case 20
%                    polarityi = 0;
%            end
% 
%            switch aaj
%                case 1
%                    polarityj = 0;
%                case 2
%                    polarityj = 1;        
%                case 3
%                    polarityj = 1;
%                case 4
%                    polarityj = 1;
%                case 5
%                    polarityj = 1;
%                case 6
%                    polarityj = 1;
%                case 7
%                    polarityj = 1;
%                case 8
%                    polarityj = 0;
%                case 9
%                    polarityj = 1;
%                case 10
%                    polarityj = 0;
%                case 11
%                    polarityj = 0;
%                case 12
%                    polarityj = 1;
%                case 13
%                    polarityj = 0;
%                case 14
%                    polarityj = 0;
%                case 15
%                    polarityj = 0;
%                case 16
%                    polarityj = 1;
%                case 17
%                    polarityj = 1;
%                case 18
%                    polarityj = 0;
%                case 19
%                    polarityj = 1;
%                case 20
%                    polarityj = 0;
%            end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%           
           %hydrophobic: hydrophobic=1  hydrophilic=0
%            switch aai
%                case 1
%                    hydroi = 0;
%                case 2
%                    hydroi = 0;        
%                case 3
%                    hydroi = 0;
%                case 4
%                    hydroi = 0;
%                case 5
%                    hydroi = 0;
%                case 6
%                    hydroi = 0;
%                case 7
%                    hydroi = 0;
%                case 8
%                    hydroi = 0;
%                case 9
%                    hydroi = 0;
%                case 10
%                    hydroi = 0;
%                case 11
%                    hydroi = 0;
%                case 12
%                    hydroi = 0;
%                case 13
%                    hydroi = 0;
%                case 14
%                    hydroi = 0;
%                case 15
%                    hydroi = 0;
%                case 16
%                    hydroi = 0;
%                case 17
%                    hydroi = 0;
%                case 18
%                    hydroi = 0;
%                case 19
%                    hydroi = 0;
%                case 20
%                    hydroi = 0;
%            end
% 
%            switch aaj
%                case 1
%                    hydroj = 0;
%                case 2
%                    hydroj = 0;        
%                case 3
%                    hydroj = 0;
%                case 4
%                    hydroj = 0;
%                case 5
%                    hydroj = 0;
%                case 6
%                    hydroj = 0;
%                case 7
%                    hydroj = 0;
%                case 8
%                    hydroj = 0;
%                case 9
%                    hydroj = 0;
%                case 10
%                    hydroj = 0;
%                case 11
%                    hydroj = 0;
%                case 12
%                    hydroj = 0;
%                case 13
%                    hydroj = 0;
%                case 14
%                    hydroj = 0;
%                case 15
%                    hydroj = 0;
%                case 16
%                    hydroj = 0;
%                case 17
%                    hydroj = 0;
%                case 1
%                    hydroj = 0;
%                case 19
%                    hydroj = 0;
%                case 20
%                    hydroj = 0;
%            end
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%        
           %1- set to zero if they have same charges
             if chargei~=0 && chargei==chargej
                 result(1,i) = 0;
             end
           %2- hydrophobic come close togther 
           
           %3- non-polars come close togther
           
           %4- polars make hydrogen bons with each other
           
           %5- polars make hydrogen bonds with +/- charges
            
            
        end 
    end
puredResult = result;
end