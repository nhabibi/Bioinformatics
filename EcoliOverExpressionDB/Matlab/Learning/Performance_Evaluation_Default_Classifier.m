
function [ result ] = Performance_Evaluation_Default_Classifier( ts )
%--------------------------------------------------------------------------    

%We know them ahead!

result.TP_Low = 0;
result.FP_Low = 0;

result.TP_Medium = 0;
result.FP_Medium = 0;

number_of_High_s = size( ts(:,:,'High') , 1);
result.TP_High = number_of_High_s;
result.FN_High = 0;
result.TN_High = 0;

%Init the variables
result.FN_Low = 0;
result.TN_Low = 0;
result.FN_Medium = 0;
result.TN_Medium = 0;
result.FP_High = 0;

for i=1:size(ts,1)   

    label = getnames( ts(i).lab );
      
    if( strcmp(label,'Low') )
    
        result.FN_Low = result.FN_Low + 1;
        result.FP_High = result.FP_High + 1;
          
    elseif( strcmp(label,'Medium') )    
         
        result.FN_Medium = result.FN_Medium + 1;
        result.FP_High = result.FP_High + 1;
        
    elseif( strcmp(label,'High') )
        
        result.TN_Low    = result.TN_Low + 1; 
        result.TN_Medium = result.TN_Medium + 1;
        
    end
    
     %Precision: TP/(TP+FP)
     result.precision_Low = result.TP_Low / (result.TP_Low + result.FP_Low);   
     result.precision_Medium = result.TP_Medium / (result.TP_Medium + result.FP_Medium);    
     result.precision_High = result.TP_High / (result.TP_High + result.FP_High);      
     
     %Recall: TP/(TP+FN)
     result.recall_Low = result.TP_Low / (result.TP_Low + result.FN_Low);           
     result.recall_Medium = result.TP_Medium / (result.TP_Medium + result.FN_Medium);         
     result.recall_High = result.TP_High / (result.TP_High + result.FN_High);             
 
     %Specificity
     result.specificity_Low = result.TN_Low / (result.TN_Low + result.FP_Low);      
     result.specificity_Medium = result.TN_Medium / (result.TN_Medium + result.FP_Medium);    
     result.specificity_High = result.TN_High / (result.TN_High + result.FP_High);         

    %--------------------------------------------------------------------------
    result.accuracy_Low    = (result.TP_Low + result.TN_Low)/(result.TP_Low + result.TN_Low + result.FP_Low + result.FN_Low);
    result.accuracy_Medium = (result.TP_Medium + result.TN_Medium)/(result.TP_Medium + result.TN_Medium + result.FP_Medium + result.FN_Medium);
    result.accuracy_High   = (result.TP_High + result.TN_High)/(result.TP_High + result.TN_High + result.FP_High + result.FN_High);
    result.accuracy_mean   = mean( [result.accuracy_Low , result.accuracy_Medium , result.accuracy_High] );

    result.error_mean = 1 - result.accuracy_mean;

    result.precision_mean = mean([result.precision_Low , result.precision_Medium , result.precision_High]);

    result.recall_mean = mean([result.recall_Low , result.recall_Medium , result.recall_High]);

    result.specificity_mean = mean([result.specificity_Low , result.specificity_Medium , result.specificity_High]);

    result.f_score_Low    = 2 * result.precision_Low * result.recall_Low / (result.precision_Low + result.recall_Low);
    result.f_score_Medium = 2 * result.precision_Medium * result.recall_Medium / (result.precision_Medium + result.recall_Medium);
    result.f_score_High   = 2 * result.precision_High * result.recall_High / (result.precision_High + result.recall_High);
    result.f_score_mean   = mean( [result.f_score_Low , result.f_score_Medium , result.f_score_High] );

    %It indicates the correlation between the classifier assignments and the actual class in the two-class case. It is a good measure of classifier performance even when classes are unbalanced [7]. The MCC ranges between ?1 and 1, and a large positive value indicates a better prediction [11].
    result.MCC_Low    = (result.TP_Low*result.TN_Low - result.FP_Low*result.FN_Low) / sqrt( (result.TP_Low+result.FP_Low)*(result.TP_Low+result.FN_Low)*(result.TN_Low+result.FP_Low)*(result.TN_Low+result.FN_Low) );
    result.MCC_Medium = (result.TP_Medium*result.TN_Medium - result.FP_Medium*result.FN_Medium) / sqrt( (result.TP_Medium+result.FP_Medium)*(result.TP_Medium+result.FN_Medium)*(result.TN_Medium+result.FP_Medium)*(result.TN_Medium+result.FN_Medium) );
    result.MCC_High   = (result.TP_High*result.TN_High - result.FP_High*result.FN_High) / sqrt( (result.TP_High+result.FP_High)*(result.TP_High+result.FN_High)*(result.TN_High+result.FP_High)*(result.TN_High+result.FN_High) );
    result.MCC_mean   = mean( [result.MCC_Low , result.MCC_Medium , result.MCC_High] );

    %It is an important performance measure that quantifies how much better the decision is in comparison with random drawing of instances.
    %Precision/proportion of the given class in the full data set.
    result.gain_Low    = result.precision_Low    / ( size(ts(:,:,'Low') , 1)    / size(ts,1) );
    result.gain_Medium = result.precision_Medium / ( size(ts(:,:,'Medium') , 1) / size(ts,1) );
    result.gain_High   = result.precision_High   / ( size(ts(:,:,'High') , 1)   / size(ts,1) );
    result.gain_mean   = mean( [result.gain_Low , result.gain_Medium , result.gain_High] );
     
    
    result.G_mean = sqrt(result.recall_Low * result.recall_Medium * result.recall_High);
    
end 

%--------------------------------------------------------------------------
end

