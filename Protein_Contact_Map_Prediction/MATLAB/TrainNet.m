%Goal: To eliminate "Catastrophic Forgetting" effect.

function [ net ] = TrainNet( NUMBER_OF_FEATURES,TRAIN_TIMES,trainSamples,net )
 
      %We just hold the begins of ranges.
      step = 1/TRAIN_TIMES;
      beginOfRanges = zeros(1,TRAIN_TIMES);
      for i=2:1:TRAIN_TIMES-1
          beginOfRanges(1,i) = beginOfRanges(1,i-1) + step;
      end
      
      endCondition = 0; counter=0; iteration=0;
      while (endCondition == 0)
          iteration = iteration+1;
          %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%          
          %first choose a random number and find the range that contains this number
          r = rand();
          found=0; range=1;
          while found==0 && range<TRAIN_TIMES
              if r < beginOfRanges(1,range+1)
                  found=1;
              else
                  range=range+1;
              end
          end
          
          %Now, refine all ranges. Here we reduce the length of selected range and increase other ranges.
          if (range==1)
             
             firstRangeLen = beginOfRanges(1,2)-beginOfRanges(1,1); 
             for i=2:1:TRAIN_TIMES
                 beginOfRanges(1,i)= beginOfRanges(1,i)- step* firstRangeLen * (TRAIN_TIMES-i+1);
             end
                          
          elseif (range==TRAIN_TIMES)
             
              lastRangeLen = 1-beginOfRanges(1,TRAIN_TIMES);               
              for i=2:1:TRAIN_TIMES
                 beginOfRanges(1,i)= beginOfRanges(1,i)+ step * lastRangeLen * (i-1);
              end
             
          else %Not begin,Not end :D
              rangeLen = beginOfRanges(1,range+1)-beginOfRanges(1,range);
              for i=2:1:range
                  beginOfRanges(1,i) = beginOfRanges(1,i) + step * rangeLen * (i-1);
              end
              for i=range+1:1:TRAIN_TIMES
                  beginOfRanges(1,i)= beginOfRanges(1,i)- step * rangeLen * (TRAIN_TIMES-i+1);
              end
          end
          
          sampleNumber = range;
          sampleNumbers{iteration} = sampleNumber;
          %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
          %Now train the given net again with selected sample
          PTMatrixTrain = trainSamples{sampleNumber};
          
          numberOfPairs = size(PTMatrixTrain,2);
          
          VLow = round((numberOfPairs/10)*(1/4));
          VHigh = ( numberOfPairs - round((numberOfPairs/10)*(3/4)) ) + 1;
          V.P = [PTMatrixTrain(1:NUMBER_OF_FEATURES,1:VLow) PTMatrixTrain(1:NUMBER_OF_FEATURES,VHigh:numberOfPairs)];
          V.T = [PTMatrixTrain(NUMBER_OF_FEATURES+1,1:VLow) PTMatrixTrain(NUMBER_OF_FEATURES+1,VHigh:numberOfPairs)];
        
                
          [net,tr] = train(net,PTMatrixTrain(1:NUMBER_OF_FEATURES,VLow+1:VHigh-1),PTMatrixTrain(NUMBER_OF_FEATURES+1,VLow+1:VHigh-1),[],[],V);          
          epoch = tr.epoch;
%????????          
%           if (epoch <= 10)
%              counter = counter+1;
%           else
%               counter = 0;
%           end
          counter = counter+1;
          if (counter == TRAIN_TIMES)
              endCondition = 1;
          end
          %counter
      end%while  
      %save('sampleNumbers.mat','sampleNumbers');
%'TrainNet() Finished.'
end