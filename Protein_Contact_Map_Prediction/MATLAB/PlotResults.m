function [] = PlotResults( nets,NUMBER_OF_FEATURES,AVG_SIZE_PROTEIN,list,dataPath,startNumber )

    figNumber = startNumber;    

    numberOfNets = size(nets,2);
    fileNames = textread(list,'%s');
    numberOfFiles =  size(fileNames,1);
    
    for i=1:1:numberOfNets
        
        for n=1:1:numberOfFiles
            
            file = load( strcat(dataPath,fileNames{n,1},'.mat') );
            PTMatrix = file.PTMatrix;
            Y = [];
            for j=1:1:i
                netTemp = nets(j).net;
                Y(j,:) = sim(netTemp,PTMatrix(1:NUMBER_OF_FEATURES,:));
            end
            [YAxis{n}] = Performance_Paper(Y,PTMatrix,NUMBER_OF_FEATURES);
        end

        %find the min size of  files
        minSizeFiles = Inf;
        for m=1:1:numberOfFiles
            tempYAxis = YAxis{1,m}; 
            if size(tempYAxis,2) < minSizeFiles
               minSizeFiles = size(tempYAxis,2);
            end
        end
        %average all the YAxis
        avgYAxis = zeros(1,minSizeFiles);
        for k=1:1:numberOfFiles
            tempYAxis = YAxis{1,k}; 
            avgYAxis = avgYAxis + tempYAxis(1,1:minSizeFiles);
        end
        avgYAxis = avgYAxis ./ numberOfFiles;
        precision = sum(avgYAxis)/minSizeFiles
 
        figure(figNumber);
        figNumber = figNumber+1;
        plot(log10((1:minSizeFiles)./AVG_SIZE_PROTEIN),avgYAxis);        
 
    end
    '************PlotResults() Finished.***************'
    
end