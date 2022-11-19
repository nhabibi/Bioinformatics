function [] = BalanceData( list,sourceDir,targetDir,numberOfFeatures )

    ZEROS_TO_ONES_RATIO = 5;

    fileNames = textread(list,'%s');
    numberOfFiles =  size(fileNames,1);
    
    for n=1:1:numberOfFiles
        col = 1;
        file = load( strcat(sourceDir,fileNames{n,1}) );
        PTMatrix = file.PTMatrix;
        
        onesIndices = find(PTMatrix(numberOfFeatures+1,:));
        onesIndices = onesIndices(:,randperm(size(onesIndices,2)));
        numberOfOnes = size(onesIndices,2);
        
        zerosIndices = find(PTMatrix(numberOfFeatures+1,:) == 0);
        zerosIndices = zerosIndices(:,randperm(size(zerosIndices,2)));
        
        balancedMatrix = zeros(numberOfFeatures+1, ZEROS_TO_ONES_RATIO * numberOfOnes);
        
        for i=1:1:numberOfOnes
            balancedMatrix(:,col) = PTMatrix(:,onesIndices(1,i));
            col = col+1;     
        end
        
        for j=1:1: (ZEROS_TO_ONES_RATIO-1) * (numberOfOnes)
            balancedMatrix(:,col) = PTMatrix(:,zerosIndices(1,j));           
            col = col+1;
        end
        
         balancedMatrix = balancedMatrix(:,randperm(size(balancedMatrix,2)));
         PTMatrix = balancedMatrix;
         
         save( strcat(targetDir,fileNames{n,1}) , 'PTMatrix');
  
    end
    'BalanceData() Finished.'
end