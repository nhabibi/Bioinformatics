function [YAxis] = Performance_Basic(netResults,PTMatrix,NUMBER_OF_FEATURES)

    desiredResults = PTMatrix(NUMBER_OF_FEATURES+1,:);
    desiredResultsSize = size(desiredResults,2);
    result = netResults;
        
    [sortedResults indices] = sort(result,'descend');
    YAxis = zeros(1,desiredResultsSize);
    for i=1:1:desiredResultsSize
        TP = 0;
        for j=1:1:i
           if desiredResults(1,indices(j)) == 1
               TP = TP+1;
           end
        end
        YAxis(1,i) = TP / i;
    end
    
    
%     if sum(puredResults) == 0
%         TP = 0;
%         %'number of predicted == 0 !!!'
%     else
%         TP = sum(puredResults .* desiredResults)/sum(puredResults);
%         %TP = sum(puredResult .* desiredResults)/desiredResultsSize;
%     end
% 
%     predictedContacts = sum(puredResults .* desiredResults)/sum(desiredResults); 
%     
%     accuracy = sum(~xor(puredResults,desiredResults)) / desiredResultsSize;
%        
end