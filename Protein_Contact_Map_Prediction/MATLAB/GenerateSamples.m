%Note: correct numberOfSamples and numberOfFiles

function [ ] = GenerateSamples( list,sourcePath,samplePath,onesPath,numberOfFeatures )

    NUMBER_OF_SAMPLES = 100;
    SAMPLE_LEN = 4;
    ONES_LEN = 1/4 * SAMPLE_LEN;
    ZEROS_LEN = 3/4 * SAMPLE_LEN;
    zerosSample = zeros(numberOfFeatures+1,ZEROS_LEN);
    
    %files = dir(sourceDir);
    %files = files(3:size(files,1));
    %numberOfFiles = size(files,1);
    files = textRead(list,'%s');
    numberOfFiles = size(files,1);
    
    %ExtractOnes(list,sourcePath,onesPath,numberOfFeatures);
    onesFile = load( strcat(onesPath,'ones.mat') );
    onesMatrix = onesFile.PTMatrix;
    onesMatrixSize = size(onesMatrix,2);
    onesSample = zeros(numberOfFeatures+1,min(ONES_LEN,onesMatrixSize));
    
    for n=1:1:NUMBER_OF_SAMPLES
        n
        %ones
        indices = ceil(1+(onesMatrixSize-1)*rand(ONES_LEN,1));
        for i=1:1:min(ONES_LEN,onesMatrixSize)
            onesSample(:,i) = onesMatrix( :,indices(i,1) );
        end
        %zeros
        j=1;
        while j ~= ZEROS_LEN+1
             rFile = ceil(1+(numberOfFiles-1)*rand()); %a + (b-a) * rand()
             randomFile = load( strcat(sourcePath,files{rFile,1}) ); 
             matrix = randomFile.PTMatrix;
             matrixLen = size(matrix,2);
             rPair = ceil(1+(matrixLen-1)*rand());
             if matrix(numberOfFeatures+1,rPair) == 0
                 zerosSample(:,j) = matrix(:,rPair);
                 j = j+1;    
             end
        end
        
        matrixSample = [onesSample zerosSample];
        matrixSample = matrixSample(:,randperm(size(matrixSample,2)));
        PTMatrix = matrixSample;
        save(strcat(samplePath,int2str(n),'.mat'),'PTMatrix');
        
        n
    end
        
    % ******************************* Version 3 *********************
    % SAMPLE_LEN = 10000;
    % ONES_LEN = 1/4 * SAMPLE_LEN;
    % ZEROS_LEN = 3/4 * SAMPLE_LEN;
    % onesSample = zeros(numberOfFeatures+1,ONES_LEN);
    % zerosSample = zeros(numberOfFeatures+1,ZEROS_LEN);
    % 
    % files = dir(dirName);
    % files = files(3:size(files,1));
    % numberOfFiles = size(files,1);
    % 
    % onesFile = load( strcat(dirName,'ones.mat') );
    % onesMatrix = onesFile.PTMatrix;
    % onesMatrixSize = size(onesMatrix,2);
    % onesSample = zeros(numberOfFeatures+1,min(ONES_LEN,onesMatrixSize));
    % indices = ceil(1+(onesMatrixSize-1)*rand(ONES_LEN,1));
    % for i=1:1:min(ONES_LEN,onesMatrixSize)
    %     onesSample(:,i) = onesMatrix( :,indices(i,1) );
    % end
    % 
    % % i=1;
    % % while i ~= ONES_LEN+1
    % %      rFile = ceil(1+(numberOfFiles-1)*rand()); %a + (b-a) * rand()
    % %      randomFile = load( strcat(dirName,files(rFile).name) ); 
    % %      matrix = randomFile.PTMatrix;
    % %      matrixLen = size(matrix,2);
    % %      rPair = ceil(1+(matrixLen-1)*rand());
    % %      if matrix(numberOfFeatures+1,rPair) == 1
    % %          onesSample(:,i) = matrix(:,rPair);
    % %          i = i+1;    
    % %      end
    % % end
    % 
    % j=1;
    % while j ~= ZEROS_LEN+1
    %      rFile = ceil(1+(numberOfFiles-1)*rand()); %a + (b-a) * rand()
    %      randomFile = load( strcat(dirName,files(rFile).name) ); 
    %      matrix = randomFile.PTMatrix;
    %      matrixLen = size(matrix,2);
    %      rPair = ceil(1+(matrixLen-1)*rand());
    %      if matrix(numberOfFeatures+1,rPair) == 0
    %          zerosSample(:,j) = matrix(:,rPair);
    %          j = j+1;    
    %      end
    % end
    % 
    % matrixSample = [onesSample zerosSample];
    % matrixSample = matrixSample(:,randperm(size(matrixSample,2)));

    % ******************************* Version 2 *********************
    %      r = ceil(1+(numberOfFiles-1)*rand()); %a + (b-a) * rand()
    %      randomFile = load( strcat(dirName,int2str(r),'.mat') ); 
    %      matrix = randomFile.PTMatrix;
    % 
    %      SAMPLE_LEN = 1000;
    %      matrixLen = size(matrix,2); 
    %      matrixSampled = zeros(size(matrix,1),SAMPLE_LEN);
    %      indices = ceil( 1 + (matrixLen-1) * rand(SAMPLE_LEN,1) );
    %      for i=1:1:SAMPLE_LEN
    %          matrixSampled(:,i) = matrix( :,indices(i,1) );
    %      end

    % ******************************* Version 1 *********************
    %    %I want to do 4 times sampling
    %    rangeLen = 300;
    %    PTLen = size(Matrix,2); 
    %    
    %    r1 = ceil(1+(PTLen/4-1)*rand()); %a + (b-a) * rand()
    %    r2 = ceil(PTLen/4+(PTLen/2-PTLen/4)*rand()); %a + (b-a) * rand()
    %    r3 = ceil(PTLen/2+(3*PTLen/4-PTLen/2)*rand()); %a + (b-a) * rand()
    %    r4 = ceil(3*PTLen/4+(PTLen-3*PTLen/4)*rand()); %a + (b-a) * rand()
    %    
    %    PTMatrixSampled(:,1:rangeLen) = Matrix(:,r1:r1+rangeLen-1);
    %    PTMatrixSampled(:,rangeLen+1:2*rangeLen) = Matrix(:,r2:r2+rangeLen-1);
    %    PTMatrixSampled(:,2*rangeLen+1:3*rangeLen) = Matrix(:,r3:r3+rangeLen-1);
    %    PTMatrixSampled(:,3*rangeLen+1:4*rangeLen) = Matrix(:,r4:r4+rangeLen-1);
'sample() Finished.'   
end