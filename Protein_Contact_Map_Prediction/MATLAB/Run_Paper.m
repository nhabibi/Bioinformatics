warning off

SAM_PATH = 'F:\Bio\workspace\Thesis\SAM\';
DATA_PATH = 'Data\';
NN_DATA_PATH = 'Data\NNData\';
TOP_4L_PAIRS_PATH = 'Data\Top4LPairs\';
LIST = 'Data\list.txt';
TRAIN_LIST = 'Data\TrainFilesList.txt';
TEST_LIST = 'Data\TestFilesList.txt';
VERIFY_LIST = 'Data\VerifyFilesList.txt';
TRAIN_SAMPLE_PATH = 'Data\TrainSamples\';
BALANCED_DATA_PATH = 'Data\BalancedData\';

NUMBER_OF_FEATURES = 529-110;  
AVG_SIZE_PROTEIN = 186; % TODO: calucate the real avg.
SIGMA = 1000;
CUTOFF_THR = 93; %TODO: it must be the lenght average of all proteins / 2
TRAIN_TIMES = 20;

NNLayerSize = 45;

%MutualInformation(SAM_PATH);

%GenerateNNData(NUMBER_OF_FEATURES,NN_DATA_PATH,LIST,SAM_PATH);
%GenerateTop4LPairs(NN_DATA_PATH,TOP_4L_PAIRS_PATH,LIST);
%GenerateSamples(TRAIN_LIST,TOP_4L_PAIRS_PATH,TRAIN_SAMPLE_PATH,ONES_PATH,NUMBER_OF_FEATURES);

%BalanceData(LIST,TOP_4L_PAIRS_PATH,BALANCED_DATA_PATH,NUMBER_OF_FEATURES);
%BalanceData(LIST,NN_DATA_PATH,BALANCED_DATA_PATH,NUMBER_OF_FEATURES);

%TOP_4L_PAIRS_PATH = BALANCED_DATA_PATH;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Round 1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
prei=1; i=1; numberOfNets=0; 

trainFileNames = textread(TRAIN_LIST,'%s');
numberOfTrainFiles =  size(trainFileNames,1);
%TRAIN_TIMES = floor( (numberOfTrainFiles/2)+1 )
%TRAIN_TIMES = 20;
testFileNames = textread(TEST_LIST,'%s');
numberOfTestFiles =  size(testFileNames,1);
    
while  i-prei<5
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Train  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    'Train Section'
    %files = dir('Train\NNTrainData\');
    %files = dir(TRAIN_SAMPLE_PATH);
    %files = files(3:size(files,1));
    %numberOfTrainFiles =  size(files,1);
        
    for n=1:1:TRAIN_TIMES
        %trainFileNames(n,1)
        %files(n).name
        %trainFile = load( strcat( 'Train\NNTrainData\',files(n).name ) );
        %trainFile = load( strcat( TRAIN_SAMPLE_PATH,files(n).name ) );
        %trainDataSet{n} = trainFile.PTMatrix;
        %trainFile = load( strcat('Train\NNTrainData\',trainFileNames{n,1},'.mat') );
        %trainSelectedPairs = Top4LPairs(trainFile.PTMatrix);
        rNumber = ceil(1+(numberOfTrainFiles-1)*rand());
        %trainSelectedPairsFile = load( strcat(TOP_4L_PAIRS_PATH,trainFileNames{rNumber,1},'.mat') );
        trainSelectedPairsFile = load( strcat(BALANCED_DATA_PATH,trainFileNames{rNumber,1},'.mat') );
        trainDataSet{n} = trainSelectedPairsFile.PTMatrix;
        %trainSampleFile = load( strcat(TRAIN_SAMPLE_PATH,trainFileNames{n,1},'.mat') );
    end
    minmaxFeatures = minmax(trainDataSet);
    minmaxFeatures = minmaxFeatures{1,1};
    minmaxFeatures = minmaxFeatures(1:NUMBER_OF_FEATURES,:); %because the last row is desired output
    
    %net = newff(minmaxFeatures, [NNLayerSize 1], {'tansig','purelin'},'trainrp');
    net = newff(minmaxFeatures, [NNLayerSize 1], {'tansig','purelin'});
    %???
 %   net.trainParam.epochs = 500;
    %??? 
    net.performFcn = 'mse';
    
    %net.trainParam.mem_reduc = 2;
    net.trainFcn = 'trainrp'; 
    net.trainParam.show = NaN;
    
    net = TrainNet(NUMBER_OF_FEATURES,TRAIN_TIMES,trainDataSet,net);
      
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Test %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    'Test Section'
    %testFiles = dir('Test\NNTestData\');
    %testFiles = testFiles(3:size(testFiles,1));
    %numberOfTestFiles = size(testFiles,1);
    
    for t=1:1:numberOfTestFiles
        %t
        %nextTestFile = load( strcat('Test\NNTestData\',testFileNames{n,1},'.mat') );
        %PTMatrixTest = nextTestFile.PTMatrix;
        %Y = sim(net,PTMatrixTest(1:NUMBER_OF_FEATURES,:));
        %[YAxis{t}] = Performance_Basic(Y,PTMatrixTest,NUMBER_OF_FEATURES);
        %testSelectedPairs = Top4LPairs(nextTestFile.PTMatrix);
        testSelectedPairsFile = load( strcat(TOP_4L_PAIRS_PATH,testFileNames{t,1},'.mat') );
        PTMatrixTest = testSelectedPairsFile.PTMatrix;
       
        Y = [];
        
        if exist('nets') %because initilizing the nets variable is not possible!!!
           netsSize = size(nets,2);
           for j=1:1:netsSize
               netTemp = nets(j).net;
               Y(j,:) = sim(netTemp,PTMatrixTest(1:NUMBER_OF_FEATURES,:));
           end
               Y(j+1,:) = sim(net,PTMatrixTest(1:NUMBER_OF_FEATURES,:));
        else
            Y(1,:) = sim(net,PTMatrixTest(1:NUMBER_OF_FEATURES,:));
        end

        [YAxis{t}] = Performance_Paper(Y,PTMatrixTest,NUMBER_OF_FEATURES);
    end%for every test file  
    
    %find the min size of test files
    minSizeTestFiles = Inf;
    for m=1:1:numberOfTestFiles
        tempYAxis = YAxis{1,m}; 
        if size(tempYAxis,2) < minSizeTestFiles
            minSizeTestFiles = size(tempYAxis,2);
        end
        
%         if size(tempYAxis,2) == 0
%             m
%         end
        
    end
    %average all the YAxis
    avgYAxis = zeros(1,minSizeTestFiles);
    for k=1:1:numberOfTestFiles
        tempYAxis = YAxis{1,k}; 
        avgYAxis = avgYAxis + tempYAxis(1,1:minSizeTestFiles);
    end
    avgYAxis = avgYAxis ./ (numberOfTestFiles);
    
    if ~exist('preAvgYAxis')
        preAvgYAxis = zeros(1,minSizeTestFiles);
    end
    
    diff = avgYAxis - preAvgYAxis;
    weight = 1/(sqrt(2*pi)*SIGMA) * exp((-(((1:minSizeTestFiles)./AVG_SIZE_PROTEIN)-CUTOFF_THR/AVG_SIZE_PROTEIN).^2)/(2*SIGMA*SIGMA));
    score = diff .* weight;
    
    %if ( sum(score)>0.001 )
    if( sum(score)>0 )
        numberOfNets = numberOfNets+1;
        nets(numberOfNets).net = net;
        nets(numberOfNets).score = sum(score);
        prei = i;
        preAvgYAxis = avgYAxis;
    end
    
    numberOfNets
    i = i+1
   
    precision = sum(avgYAxis)/minSizeTestFiles
    
    %minSizeTestFiles
    
    figure(1001);
    plot(log10((1:minSizeTestFiles)./AVG_SIZE_PROTEIN),avgYAxis);
    avgYAxisRound1 = avgYAxis;
end%while
                                              %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Setting preAvgYAxis for round 2
for t=1:1:numberOfTestFiles
        
    testSelectedPairsFile = load( strcat(TOP_4L_PAIRS_PATH,testFileNames{t,1},'.mat') );
    PTMatrixTest = testSelectedPairsFile.PTMatrix;
    Y = [];
    Y = sim(nets(numberOfNets).net,PTMatrixTest(1:NUMBER_OF_FEATURES,:));
    [YAxis{t}] = Performance_Paper(Y,PTMatrixTest,NUMBER_OF_FEATURES);
end%for every test file  
    
%find the min size of test files
minSizeTestFiles = Inf;
for m=1:1:numberOfTestFiles
    tempYAxis = YAxis{1,m}; 
    if size(tempYAxis,2) < minSizeTestFiles
       minSizeTestFiles = size(tempYAxis,2);
    end
end
%average the all YAxis
avgYAxis = zeros(1,minSizeTestFiles);
for k=1:1:numberOfTestFiles
    tempYAxis = YAxis{1,k}; 
    avgYAxis = avgYAxis + tempYAxis(1,1:minSizeTestFiles);
end
avgYAxis = avgYAxis ./ (numberOfTestFiles);
preAvgYAxis = avgYAxis;

'************Round 1 Finished.***************'
beep
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Round 2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ********************
prei=1; i=1; 
nets2(1).net = nets(numberOfNets).net;
nets2(1).score = nets(numberOfNets).score;
numberOfNets2 = 1;
clear  nets   numberOfNets
while  i-prei < 20
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Train  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    'Train Section'
    %files = dir('Train\NNTrainData\');
    %files = dir(TRAIN_SAMPLE_PATH);
    %files = files(3:size(files,1));
    %numberOfTrainFiles =  size(files,1);
%    trainFileNames = textread(TRAIN_LIST,'%s');
%    numberOfTrainFiles =  size(trainFileNames,1);
     
    for n=1:1:TRAIN_TIMES
        %trainFileNames(n,1)
        %files(n).name
        %trainFile = load( strcat( 'Train\NNTrainData\',files(n).name ) );
        %trainFile = load( strcat( TRAIN_SAMPLE_PATH,files(n).name ) );
        %trainDataSet{n} = trainFile.PTMatrix;
        %trainFile = load( strcat('Train\NNTrainData\',trainFileNames{n,1},'.mat') );
        %trainSelectedPairs = Top4LPairs(trainFile.PTMatrix);
        rNumber = ceil(1+(numberOfTrainFiles-1)*rand());
        %trainSelectedPairsFile = load( strcat(TOP_4L_PAIRS_PATH,trainFileNames{rNumber,1},'.mat') );
        trainSelectedPairsFile = load( strcat(BALANCED_DATA_PATH,trainFileNames{rNumber,1},'.mat') );
        trainDataSet{n} = trainSelectedPairsFile.PTMatrix;
        %trainSampleFile = load( strcat(TRAIN_SAMPLE_PATH,trainFileNames{n,1},'.mat') );
    end
    minmaxFeatures = minmax(trainDataSet);
    minmaxFeatures = minmaxFeatures{1,1};
    minmaxFeatures = minmaxFeatures(1:NUMBER_OF_FEATURES,:); %because the last row is desired output
    
    %net = newff(minmaxFeatures, [NNLayerSize 1], {'tansig','purelin'},'trainrp');
    net = newff(minmaxFeatures, [NNLayerSize 1], {'tansig','purelin'});
    %net.trainParam.epochs = 500;
    %net.performFcn = 'mse';
    
    %net.trainParam.mem_reduc = 2;
    net.trainFcn = 'trainrp'; 
    net.trainParam.show = NaN;
    
    net = TrainNet(NUMBER_OF_FEATURES,TRAIN_TIMES,trainDataSet,net);
      
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Test %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    'Test Section'
    %testFiles = dir('Test\NNTestData\');
    %testFiles = testFiles(3:size(testFiles,1));
    %numberOfTestFiles = size(testFiles,1);
%    testFileNames = textread(TEST_LIST,'%s');
%    numberOfTestFiles =  size(testFileNames,1);
    
    for t=1:1:numberOfTestFiles
        %t
        %nextTestFile = load( strcat('Test\NNTestData\',testFileNames{n,1},'.mat') );
        %PTMatrixTest = nextTestFile.PTMatrix;
        %Y = sim(net,PTMatrixTest(1:NUMBER_OF_FEATURES,:));
        %[YAxis{t}] = Performance_Basic(Y,PTMatrixTest,NUMBER_OF_FEATURES);
        %testSelectedPairs = Top4LPairs(nextTestFile.PTMatrix);
        testSelectedPairsFile = load( strcat(TOP_4L_PAIRS_PATH,testFileNames{t,1},'.mat') );
        PTMatrixTest = testSelectedPairsFile.PTMatrix;
       
        Y = [];
        
       netsSize = size(nets2,2);
       for j=1:1:netsSize
           netTemp = nets2(j).net;
           Y(j,:) = sim(netTemp,PTMatrixTest(1:NUMBER_OF_FEATURES,:));
       end
       Y(j+1,:) = sim(net,PTMatrixTest(1:NUMBER_OF_FEATURES,:));
       
       [YAxis{t}] = Performance_Paper(Y,PTMatrixTest,NUMBER_OF_FEATURES);
    end%for every test file  
    
    %find the min size of test files
    minSizeTestFiles = Inf;
    for m=1:1:numberOfTestFiles
        tempYAxis = YAxis{1,m}; 
        if size(tempYAxis,2) < minSizeTestFiles
            minSizeTestFiles = size(tempYAxis,2);
        end
        
%         if size(tempYAxis,2) == 0
%             m
%         end
        
    end
    %average all the YAxis
    avgYAxis = zeros(1,minSizeTestFiles);
    for k=1:1:numberOfTestFiles
        tempYAxis = YAxis{1,k}; 
        avgYAxis = avgYAxis + tempYAxis(1,1:minSizeTestFiles);
    end
    avgYAxis = avgYAxis ./ (numberOfTestFiles);
    
     if ~exist('preAvgYAxis')
        preAvgYAxis = zeros(1,minSizeTestFiles);
    end
    
    diff = avgYAxis - preAvgYAxis;
    weight = 1/(sqrt(2*pi)*SIGMA) * exp((-(((1:minSizeTestFiles)./AVG_SIZE_PROTEIN)-CUTOFF_THR/AVG_SIZE_PROTEIN).^2)/(2*SIGMA*SIGMA));
    score = diff .* weight;
    
    %if ( sum(score)>0.001 )
    if( sum(score)>0 )
        numberOfNets2 = numberOfNets2+1;
        nets2(numberOfNets2).net = net;
        nets2(numberOfNets2).score = sum(score);
        prei = i;
        preAvgYAxis = avgYAxis;
    end
    
    numberOfNets2
    i = i+1
   
    precision = sum(avgYAxis)/minSizeTestFiles
    
    %minSizeTestFiles
    
    figure(1002);
    plot(log10((1:minSizeTestFiles)./AVG_SIZE_PROTEIN),avgYAxis);
    
end%while
'************Round 2 Finished.***************'
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Verification %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%*
 verifyFileNames = textread(VERIFY_LIST,'%s');
 numberOfVerifyFiles =  size(verifyFileNames,1);
    
 for v=1:1:numberOfVerifyFiles
        %t
        %nextTestFile = load( strcat('Test\NNTestData\',testFileNames{n,1},'.mat') );
        %PTMatrixTest = nextTestFile.PTMatrix;
        %Y = sim(net,PTMatrixTest(1:NUMBER_OF_FEATURES,:));
        %[YAxis{t}] = Performance_Basic(Y,PTMatrixTest,NUMBER_OF_FEATURES);
        %testSelectedPairs = Top4LPairs(nextTestFile.PTMatrix);
        verifySelectedPairsFile = load( strcat(TOP_4L_PAIRS_PATH,verifyFileNames{v,1},'.mat') );
        PTMatrixVerify = verifySelectedPairsFile.PTMatrix;
        
        YVerify = [];
        for j=1:1:numberOfNets2
            netTempVerify = nets2(j).net;
            YVerify(j,:) = sim(netTempVerify,PTMatrixVerify(1:NUMBER_OF_FEATURES,:));
        end
            
        [YAxisVerify{v}] = Performance_Paper(YVerify,PTMatrixVerify,NUMBER_OF_FEATURES);
 end
 %find the min size of verification files
 minSizeVerifyFiles = Inf;
 for m=1:1:numberOfVerifyFiles
     tempYAxisVerify = YAxisVerify{1,m}; 
     if size(tempYAxisVerify,2) < minSizeVerifyFiles
         minSizeVerifyFiles = size(tempYAxisVerify,2);
     end
 end
 %average all the YAxis
 avgYAxisVerify = zeros(1,minSizeVerifyFiles);
 for k=1:1:numberOfVerifyFiles
     tempYAxisVerify = YAxisVerify{1,k}; 
     avgYAxisVerify = avgYAxisVerify + tempYAxisVerify(1,1:minSizeVerifyFiles);
 end
 avgYAxisVerify = avgYAxisVerify ./ numberOfVerifyFiles;
 verificationPrecision = sum(avgYAxisVerify)/minSizeVerifyFiles
 
 figure(1003);
 plot(log10((1:minSizeVerifyFiles)./AVG_SIZE_PROTEIN),avgYAxisVerify);        
     
 '************Verification Finished.***************'
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%End Of Verification %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ********************

%PlotResults( nets2,NUMBER_OF_FEATURES,AVG_SIZE_PROTEIN,VERIFY_LIST,TOP_4L_PAIRS_PATH,1 )

     
