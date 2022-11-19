function ExtractOnes( list,sourcePath,onesPath,numberOfFeatures )

    counter = 1;
    
    files = textRead(list,'%s');
    numberOfFiles = size(files,1);
    
    for i=1:1:numberOfFiles
        file  = load( strcat(sourcePath,files{i,1}) );
        matrix = file.PTMatrix;
        indices = find(matrix(numberOfFeatures+1,:)); 
        indicesSize = size(indices,2);
        for j=1:1:indicesSize
            PTMatrix(:,counter) =  matrix(:,indices(1,j));
            counter = counter+1;
        end
        %i
    end
    save(strcat(onesPath,'ones.mat'),'PTMatrix');
    'ExtractOnes() Finished.'
end