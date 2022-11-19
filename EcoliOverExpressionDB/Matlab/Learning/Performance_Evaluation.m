function [ result ] = Performance_Evaluation( performance , ts )
%--------------------------------------------------------------------------    
   
    result.error_mean         = performance(1,1);
    result.error_Low          = performance(1,2);
    result.error_Medium       = performance(1,3);
    result.error_High         = performance(1,4);

    result.TP_Low             = performance(1,5);
    result.FP_Low             = performance(1,6);
    result.TN_Low             = performance(1,7);
    result.FN_Low             = performance(1,8);

    result.TP_Medium          = performance(1,9);
    result.FP_Medium          = performance(1,10);
    result.TN_Medium          = performance(1,11);
    result.FN_Medium          = performance(1,12);

    result.TP_High            = performance(1,13);
    result.FP_High            = performance(1,14);
    result.TN_High            = performance(1,15);
    result.FN_High            = performance(1,16);

    %result.TPr_Low            = performance(1,17);
    %result.FPr_Low            = performance(1,18);
    %result.TNr_Low            = performance(1,19);
    %result.FNr_Low            = performance(1,20);

    %result.TPr_Medium         = performance(1,21);
    %result.FPr_Medium         = performance(1,22);
    %result.TNr_Medium         = performance(1,23);
    %result.FNr_Medium         = performance(1,24);

    %result.TPr_High           = performance(1,25);
    %result.FPr_High           = performance(1,26);
    %result.TNr_High           = performance(1,27);
    %result.FNr_High           = performance(1,28);

    result.precision_Low      = performance(1,29);
    result.precision_Medium   = performance(1,30);
    result.precision_High     = performance(1,31);

    result.recall_Low         = performance(1,32);
    result.recall_Medium      = performance(1,33);
    result.recall_High        = performance(1,34);

    result.specificity_Low    = performance(1,35);
    result.specificity_Medium = performance(1,36);
    result.specificity_High   = performance(1,37);

    %--------------------------------------------------------------------------
    result.accuracy_Low    = (result.TP_Low + result.TN_Low)/(result.TP_Low + result.TN_Low + result.FP_Low + result.FN_Low);
    result.accuracy_Medium = (result.TP_Medium + result.TN_Medium)/(result.TP_Medium + result.TN_Medium + result.FP_Medium + result.FN_Medium);
    result.accuracy_High   = (result.TP_High + result.TN_High)/(result.TP_High + result.TN_High + result.FP_High + result.FN_High);
    result.accuracy_mean   = mean( [result.accuracy_Low , result.accuracy_Medium , result.accuracy_High] );

    result.my_error_mean = 1 - result.accuracy_mean;

    result.precision_mean = mean([result.precision_Low , result.precision_Medium , result.precision_High]);

    result.recall_mean = mean([result.recall_Low , result.recall_Medium , result.recall_High]);

    result.specificity_mean = mean([result.specificity_Low , result.specificity_Medium , result.specificity_High]);

    result.f_score_Low    = 2 * result.precision_Low * result.recall_Low / (result.precision_Low + result.recall_Low);
    result.f_score_Medium = 2 * result.precision_Medium * result.recall_Medium / (result.precision_Medium + result.recall_Medium);
    result.f_score_High   = 2 * result.precision_High * result.recall_High / (result.precision_High + result.recall_High);
    result.f_score_mean   = mean( [result.f_score_Low , result.f_score_Medium , result.f_score_High] );

    %MCC ranges between -1 and 1, and a large positive value indicates a better prediction.
    result.MCC_Low    = (result.TP_Low*result.TN_Low - result.FP_Low*result.FN_Low) / sqrt( (result.TP_Low+result.FP_Low)*(result.TP_Low+result.FN_Low)*(result.TN_Low+result.FP_Low)*(result.TN_Low+result.FN_Low) );
    result.MCC_Medium = (result.TP_Medium*result.TN_Medium - result.FP_Medium*result.FN_Medium) / sqrt( (result.TP_Medium+result.FP_Medium)*(result.TP_Medium+result.FN_Medium)*(result.TN_Medium+result.FP_Medium)*(result.TN_Medium+result.FN_Medium) );
    result.MCC_High   = (result.TP_High*result.TN_High - result.FP_High*result.FN_High) / sqrt( (result.TP_High+result.FP_High)*(result.TP_High+result.FN_High)*(result.TN_High+result.FP_High)*(result.TN_High+result.FN_High) );
    result.MCC_mean   = mean( [result.MCC_Low , result.MCC_Medium , result.MCC_High] );

    %Precision/proportion of the given class in the full data set.
    result.gain_Low    = result.precision_Low    / ( size(ts(:,:,'Low') , 1)    / size(ts,1) );
    result.gain_Medium = result.precision_Medium / ( size(ts(:,:,'Medium') , 1) / size(ts,1) );
    result.gain_High   = result.precision_High   / ( size(ts(:,:,'High') , 1)   / size(ts,1) );
    result.gain_mean   = mean( [result.gain_Low , result.gain_Medium , result.gain_High] );

    %G-mean
    result.G_mean = (result.recall_Low * result.recall_Medium * result.recall_High) ^ 1/3; 
        
%--------------------------------------------------------------------------
end

