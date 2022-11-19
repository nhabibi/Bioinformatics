function [ ] = GenerateTop4LPairs(NN_DATA_PATH,TOP_4L_PAIRS_PATH,LIST)

    fileNames = textread(LIST,'%s');
    numberOfFiles = size(fileNames,1);
    
    for n=1:1:numberOfFiles
            
            %fileNames{n,1}    
            n
            
            file = load( strcat(NN_DATA_PATH,fileNames{n,1}) );
            PTMatrix = file.PTMatrix;
            
            proteinLen = round(PTMatrix(1,1)^2.71); %cause it is saved as log(seqLen)
            PTMatrix = PTMatrix';

            %number of pairs
          %  m1 = sortrows(PTMatrix,-525);
            m1 = sortrows(PTMatrix,-415);
            m1 = m1(1:4*proteinLen,:);
            %MI-log rank
          %  m2 = sortrows(PTMatrix,-527);
            m2 = sortrows(PTMatrix,417);
            m2 = m2(1:4*proteinLen,:);
            %propensity-log rank
          %  m3 = sortrows(PTMatrix,-528);
            m3 = sortrows(PTMatrix,-418);
            m3 = m3(1:4*proteinLen,:);
            %joint entropy-log rank
          %  m4 = sortrows(PTMatrix,529);
            m4 = sortrows(PTMatrix,419);
            m4 = m4(1:4*proteinLen,:);

            m12 = union(m1,m2,'rows');
            m123 = union(m12,m3,'rows');
            m1234 = union(m123,m4,'rows');

            selectedPairs = m1234';
            PTMatrix = selectedPairs;
            
            save(strcat(TOP_4L_PAIRS_PATH,fileNames{n,1}),'PTMatrix');
            
    end

    'top4LPairs() Finished'

end