
function  GenerateNNData(numberOfFeatures,NN_DATA_PATH,LIST,SAM_PATH)

    %AA_NUMBER = 20;
    %NOT_DEFINED = NaN;
    LOCAL_DIST = 8; 
        
    EPDB_EXT = '.epdb';
    AA_DISTRIBUTION_EXT = '.aad';
    SS_EXT = '.ss';
    BURIAL_EXT = '.burial';
    ENTROPY_EXT = '.ent';
    NUMBER_OF_PAIRS_EXT = '.nop';
    MUTUAL_INFORMATION_EXT = '.mi';
    RANK_MUTUAL_INFORMATION_EXT = '.rankmi';
    RANK_JOINT_ENTROPY_EXT = '.rankje';
    RANK_PROPENSITY_EXT = '.rankprop';
     
    fileNames = textread(LIST,'%s');
    numberOfFiles =  size(fileNames,1);
    
    %For every protein do:
    for n=1:1:numberOfFiles
           
        counter=1;
        fileName = fileNames{n,1};
        p = load(strcat(SAM_PATH,fileName,EPDB_EXT));
        %Getting Amino Acid Distribution
        aad = load( strcat(SAM_PATH,fileName,AA_DISTRIBUTION_EXT) );
        %Getting Predicted Secondary Structure
        %SS = textread( strcat(SAM_PATH,fileName,SS_EXT) , '%c' );
        %SS = SS - 0;
        ss = load( strcat(SAM_PATH,fileName,SS_EXT) );
        %Getting Predicted Burial
        %burial = textread( strcat(SAM_PATH,fileName,BURIAL_EXT) , '%c' );
        %burial = burial - 0;
        burial = load( strcat(SAM_PATH,fileName,BURIAL_EXT) );
        %Getting Entropy
        entropy = load( strcat(SAM_PATH,fileName,ENTROPY_EXT) );
        %Getting Number of Pairs
        NOP = load( strcat(SAM_PATH,fileName,NUMBER_OF_PAIRS_EXT) );
        %Getting MI
        MI = load( strcat(SAM_PATH,fileName,MUTUAL_INFORMATION_EXT) );
        MIRank = load( strcat(SAM_PATH,fileName,RANK_MUTUAL_INFORMATION_EXT) );
        %Getting Propensity
        PropRank = load( strcat(SAM_PATH,fileName,RANK_PROPENSITY_EXT) );
        %Getting Joint Entropy
        JERank = load( strcat(SAM_PATH,fileName,RANK_JOINT_ENTROPY_EXT) );
        %Generate CM for protein
        pCM = NCM(p,8);
        
        pSize = size(p,1);
        %PTMatrix = zeros(numberOfFeatures+1,nchoosek(pSize-LOCAL_DIST,2));
        PTMatrix = zeros(numberOfFeatures+1,nchoosek(pSize,2));
        %matName = strcat(targetPath,fileName,'.mat');
        matName = strcat(NN_DATA_PATH,fileName,'.mat');
               
        %for every AminAcids pair do:
%         for i=1:1:pSize-LOCAL_DIST
%             for j=i+LOCAL_DIST:1:pSize
        for i=3:1:pSize-LOCAL_DIST
            for j=i+LOCAL_DIST:1:pSize-2
                %p(i,1)
                %p(j,1)
                %if(i-2>=1 && j+2<=pSize )
                
                        %%%%%%%%%%%%%%sequence inputs%%%%%%%%%%%
                       
                        %sequnece len 
                        seqLen = pSize;
                        seqLen = log(seqLen);
                       
                        %sequence seperation
                        seqSep = j-i;
                        seqSep = log(seqSep);
                        
                        %%%%%%%%%%%%%%single-column inputs%%%%%%%%%%%
                            
                        %AA distribution - Window 5
                        aadiMinus2 = aad(i-2,:)'; aadiMinus1 = aad(i-1,:)'; aadi = aad(i,:)';  aadiPlus1 = aad(i+1,:)'; aadiPlus2 = aad(i+2,:)';  aadjMinus2 = aad(j-2,:)'; aadjMinus1 = aad(j-1,:)'; aadj = aad(j,:)'; aadjPlus1 = aad(j+1,:)'; aadjPlus2 = aad(j+2,:)';
                        %predicted secondary structure - Window 5                      
                        ssiMinus2 = ss(i-2,:)';  ssiMinus1 = ss(i-1,:)' ; ssi = ss(i,:)';  ssiPlus1 = ss(i+1,:)';  ssiPlus2 = ss(i+2,:)';   ssjMinus2 = ss(j-2,:)';  ssjMinus1 = ss(j-1,:)';  ssj = ss(j,:)';  ssjPlus1 = ss(j+1,:)';  ssjPlus2 = ss(j+2,:)';
                        %predicted burial
                        burialiMinus2 = burial(i-2,:)'; burialiMinus1 = burial(i-1,:)'; buriali = burial(i,:)'; burialiPlus1 = burial(i+1,:)'; burialiPlus2 = burial(i+2,:)'; burialjMinus2 = burial(j-2,:)'; burialjMinus1 = burial(j-1,:)'; burialj = burial(j,:)'; burialjPlus1 = burial(j+1,:)'; burialjPlus2 = burial(j+2,:)'; 
                        %entropy
                        enti = entropy(i); entj = entropy(j);
                        
                        %%%%%%%%%%%%%%paired-column inputs%%%%%%%%%%
                        
                        %number of pairs
                        nopij = NOP(i,j);
                                               
                        %Mutual information - value and log rank
                        miij = MI(i,j);
                        miRankij = log(MIRank(i,j));
                        
                        %propensity - log rank
                        propRankij = log(PropRank(i,j));
                        
                        %joint entropy - log rank
                        jeRankij = log(JERank(i,j));
                       
                        %%%%%%%%%%%%%%%%%%%output%%%%%%%%%%%%%%%%%%%
                       
                        %desired output
                        desiredOutput = pCM(i,j);
                        
                        %add aboves to PTMatrix
                        %PTMatrix(:,counter) = [seqLen;seqSep  ;  aadiMinus2;aadiMinus1;aadi;aadiPlus1;aadiPlus2;aadjMinus2;aadjMinus1;aadj;aadjPlus1;aadjPlus2;ssiMinus2;ssiMinus1;ssi;ssiPlus1;ssiPlus2;ssjMinus2;ssjMinus1;ssj;ssjPlus1;ssjPlus2;burialiMinus2;burialiMinus1;buriali;burialiPlus1;burialiPlus2;burialjMinus2;burialjMinus1;burialj;burialjPlus1;burialjPlus2;enti;entj  ;   nopij;miij;miRankij;propRankij;jeRankij ;  desiredOutput];
                        PTMatrix(:,counter) = [seqLen;seqSep  ;  aadiMinus2;aadiMinus1;aadi;aadiPlus1;aadiPlus2;aadjMinus2;aadjMinus1;aadj;aadjPlus1;aadjPlus2;ssiMinus2;ssiMinus1;ssi;ssiPlus1;ssiPlus2;ssjMinus2;ssjMinus1;ssj;ssjPlus1;ssjPlus2;enti;entj  ;   nopij;miij;miRankij;propRankij;jeRankij ;  desiredOutput];
                        counter = counter+1;
                %end %if
            end%for j
        end%for i
        PTMatrix = PTMatrix(:,1:counter-1);
        %PTMatrix = sparse(PTMatrix);
        %PTMatrix = single(PTMatrix);
        save(matName,'PTMatrix');
        n
     end%for n

'GenerateNNData() Finished'
end

