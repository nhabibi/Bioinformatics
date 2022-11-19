%function Run_Basic()

SAM_PATH = 'F:\Bio\workspace\Thesis\SAM\';
DATA_PATH = 'Data\';
NN_DATA_PATH = 'Data\NNData\';
TOP_4L_PAIRS_PATH = 'Data\Top4LPairs\';
LIST = 'Data\list.txt';
TRAIN_LIST = 'Data\TrainFilesList.txt';
TEST_LIST = 'Data\TestFilesList.txt';
TRAIN_SAMPLE_PATH = 'Data\TrainSamples\';
ONES_PATH = DATA_PATH;
BALANCED_DATA_PATH = 'Data\BalancedData\';

NUMBER_OF_FEATURES = 529-110;  
AVG_SIZE_PROTEIN = 186;

NUMBER_OF_NETS = 10;

%MutualInformation(SAM_PATH);

%GenerateNNData(NUMBER_OF_FEATURES,NN_DATA_PATH,LIST,SAM_PATH);
%GenerateTop4LPairs(NN_DATA_PATH,TOP_4L_PAIRS_PATH,LIST);
%GenerateSamples(TRAIN_LIST,TOP_4L_PAIRS_PATH,TRAIN_SAMPLE_PATH,ONES_PATH,NUMBER_OF_FEATURES);

%BalanceData(LIST,TOP_4L_PAIRS_PATH,BALANCED_DATA_PATH,NUMBER_OF_FEATURES);
%BalanceData(LIST,NN_DATA_PATH,BALANCED_DATA_PATH,NUMBER_OF_FEATURES);

%TOP_4L_PAIRS_PATH = BALANCED_DATA_PATH;

NNLayerSize = 45;

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Train  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    'Train Section'
    %files = dir('Train\NNTrainData\');
    %files = dir(TRAIN_SAMPLE_PATH);
    %files = files(3:size(files,1));
    %numberOfTrainFiles =  size(files,1);
    trainFileNames = textread(TRAIN_LIST,'%s');
    numberOfTrainFiles =  size(trainFileNames,1);
     
    for n=1:1:numberOfTrainFiles
        %trainFileNames(n,1)
        %files(n).name
        %trainFile = load( strcat( 'Train\NNTrainData\',files(n).name ) );
        %trainFile = load( strcat( TRAIN_SAMPLE_PATH,files(n).name ) );
        %trainDataSet{n} = trainFile.PTMatrix;
        %trainFile = load( strcat('Train\NNTrainData\',trainFileNames{n,1},'.mat') );
        %trainSelectedPairs = Top4LPairs(trainFile.PTMatrix);
        trainSelectedPairsFile = load( strcat(BALANCED_DATA_PATH,trainFileNames{n,1},'.mat') );
        trainDataSet{n} = trainSelectedPairsFile.PTMatrix;
        %trainSampleFile = load( strcat(TRAIN_SAMPLE_PATH,trainFileNames{n,1},'.mat') );
    end
    minmaxFeatures = minmax(trainDataSet);
    minmaxFeatures = minmaxFeatures{1,1};
    minmaxFeatures = minmaxFeatures(1:NUMBER_OF_FEATURES,:); %because the last row is desired output
    
    for m=1:1:NUMBER_OF_NETS
        m
        net = newff(minmaxFeatures, [NNLayerSize 1], {'tansig','purelin'});
        %net.trainParam.epochs = 500;
        %net.performFcn = 'mse';
        %net.trainParam.mem_reduc = 2;
        net.trainFcn = 'trainrp'; 
        net.trainParam.show = NaN;
        %net = TrainNet(NUMBER_OF_FEATURES,numberOfTrainFiles,trainDataSet,net);
        
        for i=1:1:numberOfTrainFiles
            %trainFileNames{i,1}
            %i
            PTMatrixTrain = trainDataSet{i};
          
            %trainSelectedPairsFile = load( strcat(TOP_4L_PAIRS_PATH,trainFileNames{i,1},'.mat') );
            %PTMatrixTrain = trainSelectedPairsFile.PTMatrix;
        
            %trainFile = load( strcat( TRAIN_SAMPLE_PATH,files(i).name ) );
            %PTMatrixTrain = trainFile.PTMatrix;
                        
            numberOfPairs = size(PTMatrixTrain,2);
            VLow = round((numberOfPairs/10)*(1/4));
            VHigh = ( numberOfPairs - round((numberOfPairs/10)*(3/4)) ) + 1;
            V.P = [PTMatrixTrain(1:NUMBER_OF_FEATURES,1:VLow) PTMatrixTrain(1:NUMBER_OF_FEATURES,VHigh:numberOfPairs)];
            V.T = [PTMatrixTrain(NUMBER_OF_FEATURES+1,1:VLow) PTMatrixTrain(NUMBER_OF_FEATURES+1,VHigh:numberOfPairs)];
        
            %clear  trainSelectedPairsFile
            %clear trainDataSet
            %PTMatrixTrain = sparse(PTMatrixTrain);
            %pack
        
            net = train(net,PTMatrixTrain(1:NUMBER_OF_FEATURES,VLow+1:VHigh-1),PTMatrixTrain(NUMBER_OF_FEATURES+1,VLow+1:VHigh-1),[],[],V);          
        end
        nets{m} = net;
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Test %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    'Test Section'
    %testFiles = dir('Test\NNTestData\');
    %testFiles = testFiles(3:size(testFiles,1));
    %numberOfTestFiles = size(testFiles,1);
    testFileNames = textread(TEST_LIST,'%s');
    numberOfTestFiles =  size(testFileNames,1);
    
    %pack
    %correctOnes = zeros(numberOfTestFiles,1);
    %wrongOnes = zeros(numberOfTestFiles,1);
    
    for t=1:1:numberOfTestFiles
        t
        %nextTestFile = load( strcat('Test\NNTestData\',testFileNames{n,1},'.mat') );
        %PTMatrixTest = nextTestFile.PTMatrix;
        %Y = sim(net,PTMatrixTest(1:NUMBER_OF_FEATURES,:));
        %[YAxis{t}] = Performance_Basic(Y,PTMatrixTest,NUMBER_OF_FEATURES);
        %testSelectedPairs = Top4LPairs(nextTestFile.PTMatrix);
        testSelectedPairsFile = load( strcat(TOP_4L_PAIRS_PATH,testFileNames{t,1},'.mat') );
        PTMatrixTest = testSelectedPairsFile.PTMatrix;
        %Y = sim(net,PTMatrixTest(1:NUMBER_OF_FEATURES,:));
        %[YAxis{t}] = Performance_Basic(Y,PTMatrixTest,NUMBER_OF_FEATURES);
        %[correctOnes(t,1) wrongOnes(t,1)] = Precision(PTMatrixTest , Y , NUMBER_OF_FEATURES);
        
        Y = [];
        for j=1:1:NUMBER_OF_NETS
            netTemp = nets{j};
            Y(j,:) = sim(netTemp,PTMatrixTest(1:NUMBER_OF_FEATURES,:));
        end

        [YAxis{t}] = Performance_EnsAvg(Y,PTMatrixTest,NUMBER_OF_FEATURES);
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
    %average the all YAxis
    avgYAxis = zeros(1,minSizeTestFiles);
    for k=1:1:numberOfTestFiles
        tempYAxis = YAxis{1,k}; 
        avgYAxis = avgYAxis + tempYAxis(1,1:minSizeTestFiles);
    end
    avgYAxis = avgYAxis ./ (numberOfTestFiles);
    
    %avgCorrectOnes = mean(correctOnes)
    %avgWrongOnes = mean(wrongOnes)
    precision = sum(avgYAxis)/minSizeTestFiles
    
    %minSizeTestFiles
    
    figure(1);
    plot(log10((1:minSizeTestFiles)./AVG_SIZE_PROTEIN),avgYAxis);
    
 %end        
