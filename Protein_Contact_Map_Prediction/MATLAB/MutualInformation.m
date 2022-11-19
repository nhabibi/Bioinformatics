function [ ] = MutualInformation(SAM_PATH)

    warning off
   
    NUMERIC_THIN_MSA_EXT = '.numericthinmsa';
    MUTUAL_INFORMATION_EXT = '.mi';
    RANK_MUTUAL_INFORMATION_EXT = '.rankmi';
    P_VALUE_EXT = '.pvalue';
    
    files = dir(strcat(SAM_PATH,'*',NUMERIC_THIN_MSA_EXT));
    %files = files(3:size(files,1));
    numberOfFiles = size(files,1);

    %For every file do:
    for n=1:1:numberOfFiles
    %for n=1:1:1
        n   
        fileName = files(n).name;
        dotLoc = findstr(fileName,'.');
        fileNameNoExt = fileName(1:dotLoc-1)
        
        MSA = load( strcat(SAM_PATH,fileNameNoExt,NUMERIC_THIN_MSA_EXT) );
        pLen = size(MSA,2);
        %NALIGN = size(MSA,1);
        MIMatrix = zeros(pLen,pLen);
        p_valueMatrix = zeros(pLen,pLen);
                    
        for i=1:1:pLen
            for j=i:1:pLen
                %i
                %j
                colI = MSA(:,i);  colJ = MSA(:,j);
                CTOriginal = contigencyTable(colI,colJ);
                miOriginal = MI(colI,colJ);
                if(miOriginal==0)
                    MIMatrix(i,j) = 1 * sum(sum(CTOriginal));%according to Dr. Karplus e-mail
                else
                    miRandoms = zeros(50,1);
                    for p=1:1:50
                        %p
                        CTRandom = 0;
                        %because sum(sum(CT))==0, makes the MI==NaN
                        while( sum(sum(CTRandom)) == 0 )
                            colJRandom = colJ(randperm(size(colJ)),1);%permute colJ
        			        CTRandom = contigencyTable(colI,colJRandom);
                        end
                        miRandoms(p,1) = MI(colI,colJRandom);
                    end%p
                    
                    phat = gamfit(miRandoms);
                    alpha = phat(1,1);
                    beta = phat(1,2);
                           
                    p_valueMatrix(i,j) = 1-gamcdf(miOriginal,alpha,beta);
                    MIMatrix(i,j) = p_valueMatrix(i,j) * sum(sum(CTOriginal));
                    
                    temp = p_valueMatrix(i,j);
                    if( temp<0 || temp>1 || isinf(temp) || isnan(temp) )
                        miOriginal
                        alpha
                        beta
                        temp
                    end
                               
                end%if(miOriginal==0)
             end%j
        end%i
        
        %fill the bottom half from the top half
        for i=1:1:pLen
            for j=i+1:1:pLen
                MIMatrix(j,i) = MIMatrix(i,j);
                p_valueMatrix(j,i) = p_valueMatrix(i,j);
            end
        end
        
        p_valueRankMatrix = rankMatrix(p_valueMatrix);
        
%'End of First Step'
         %*******************************************************************       
         %for the 4pLen pairs which have the lowest estimatad p-values, we recompute the p-values using 500 random tables
        [row,col,value] = find(p_valueRankMatrix <= 4*pLen);
        numberOfIndices = size(row,1) %or size(col,1)
        for m=1:1:numberOfIndices
            i = row(m);
            j = col(m);
            if(j>=i)
                colI = MSA(:,i);  colJ = MSA(:,j);
                CTOriginal = contigencyTable(colI,colJ);
                miOriginal = MI(colI,colJ);
                if(miOriginal==0)
                    MIMatrix(i,j) = 1 * sum(sum(CTOriginal));
                else
                    miRandoms = zeros(500,1);
                    for p=1:1:500
                        CTRandom = 0;
                        %because sum(sum(CT))==0, makes the MI==NaN
                        while( sum(sum(CTRandom)) == 0 )
                            colJRandom = colJ(randperm(size(colJ)),1);%permute colJ
        			        CTRandom = contigencyTable(colI,colJRandom);
                        end
                        miRandoms(p,1) = MI(colI,colJRandom);
                    end%p

                    phat = gamfit(miRandoms);
                    alpha = phat(1,1);
                    beta = phat(1,2);
                           
                    p_valueMatrix(i,j) = 1-gamcdf(miOriginal,alpha,beta);
                    MIMatrix(i,j) = p_valueMatrix(i,j) * sum(sum(CTOriginal));
                 
                    temp = p_valueMatrix(i,j);
                    if( temp<0 || temp>1 || isinf(temp) || isnan(temp) )
                        miOriginal
                        alpha
                        beta
                        temp
                    end
                                      
                end%if(miOriginal==0)    
            end%if(j>=i)     
        end%for m
        
        %fill the bottom half from the top half
        for i=1:1:pLen
            for j=i+1:1:pLen
                MIMatrix(j,i) = MIMatrix(i,j);
                p_valueMatrix(j,i) = p_valueMatrix(i,j);
            end
        end
        %*******************************************************************        
        rankMIMatrix = rankMatrix(MIMatrix);
        
        save(strcat(SAM_PATH,fileNameNoExt,P_VALUE_EXT),'p_valueMatrix','-ASCII');
        save(strcat(SAM_PATH,fileNameNoExt,MUTUAL_INFORMATION_EXT),'MIMatrix','-ASCII');
        save(strcat(SAM_PATH,fileNameNoExt,RANK_MUTUAL_INFORMATION_EXT),'rankMIMatrix','-ASCII'); 
    end %n
    
    'MutualInformation() Finished.'
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [CT] = contigencyTable(colI,colJ)
 
       AMINO_ACID_NUMBER = 20;
       NALIGN = size(colI,1); %or size(colJ)
	   CT = zeros(AMINO_ACID_NUMBER,AMINO_ACID_NUMBER);
       for m=1:1:NALIGN
    	   firstAA  = colI(m);
    	   secondAA = colJ(m);
    	   %we omit sequences which have a gap in either column.
    	   if(firstAA>0 && secondAA>0)
    		  CT(firstAA,secondAA) = CT(firstAA,secondAA) +1;
           end
       end
end 		
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [result] = MI(colI,colJ)
   
   result = 0;
   AMINO_ACID_NUMBER = 20;
   CT = contigencyTable(colI,colJ);
   sumCT = sum(sum(CT));
   for i=1:1:AMINO_ACID_NUMBER
       pi = sum(CT(i,:))/sumCT;
       if(pi ~= 0)
           for j=1:1:AMINO_ACID_NUMBER
               pj = sum(CT(:,j))/sumCT;
               if( pj ~= 0 )
                  pij = CT(i,j)/sumCT; 
                  if( pij ~= 0 )
                        result = result + pij*log( pij/(pi*pj) );
                  end
               end
           end
       end
   end
   
   if( result == -0.0000 )
       result = 0;
   end
   
   if( result < 0 )
       result
       colI'
       colJ'
   end
   
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [result] = rankMatrix(matrix)
	  
	 matrixRowsNumber = size(matrix,1);
	 matrixColsNumber = size(matrix,2);
	 %array = zeros(matrixRowsNumber*matrixColsNumber);
     
	 for i=1:1:matrixRowsNumber
		 for j=1:1:matrixColsNumber
			 vAi.value = matrix(i,j);
			 vAi.i = i;
			 vAi.j = j;
			 array((i-1)*matrixColsNumber + j,1) = vAi; 
         end
     end
     
	 %sort the array
	 min = -10000;
	 for i=1:1:size(array,1)-1
		 min = i;
		 for j=i+1:1:size(array,1)
			 if(array(j).value < array(min).value)
				 min = j;
             end
         end
		 if(min ~= i)
			 vAitemp = array(i);
			 array(i) = array(min);
			 array(min) = vAitemp;
         end
     end
     
	 %write the rank of every entry into a matrix
	 result = zeros(matrixRowsNumber,matrixColsNumber);
	 result( array(1).i , array(1).j ) = 1;
	 rankTemp = 1;
	 for n=2:1:size(array,1)
		 if array(n).value ~= array(n-1).value
             rankTemp=rankTemp+1;
         end
		 result(array(n).i , array(n).j) = rankTemp;
     end
	 	 
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%