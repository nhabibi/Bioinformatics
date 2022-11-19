%according to papers, top Lp pairs, are considered to be as contacts and the rest, as non-contacts.
function [ correctOnes,wrongOnes ] = Precision( PTMatrix,predicted,numberOfFeatures )

    correctOnes=0; wrongOnes=0; 
    Lp = 2.7 ^ PTMatrix(1,1);
    NUMBER_OF_ONES = Lp/2;
    real = PTMatrix(numberOfFeatures+1,:);
    [sortedR rIndices] = sort(real,'descend'); 
    [sortedP pIndices] = sort(predicted,'descend'); 
    
    for n=1:1:NUMBER_OF_ONES
        if find( rIndices==pIndices(1,n) ) < NUMBER_OF_ONES
           correctOnes = correctOnes + 1;
        else
           wrongOnes = wrongOnes + 1;
        end
    end

    correctOnes = correctOnes/NUMBER_OF_ONES;
    wrongOnes = wrongOnes/NUMBER_OF_ONES;

end
