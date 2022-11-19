 
%----------------------------Default Classifier----------------------------


% For Leave-One-Out -------------------------------------------------------
% number_of_data = size(a,1);
% n = number_of_data;
% K = number_of_data;
% fold_length = floor(n/K);
%--------------------------------------------------------------------------

%For K-fold ---------------------------------------------------------------
% number_of_data = size(a,1);
% n = number_of_data;
% K = 10;
% fold_length = floor(n/K);
%--------------------------------------------------------------------------

for i=1:K
i

%-------------------------------------------------------------------------
%SPLIT DATA FOR K-FOLD CROSS-VALIDATION
%-------------------------------------------------------------------------
             
if (i==1)      
    
    ts = a( 1 : fold_length );  
    tr = a( fold_length+1 : end );
          
elseif (i==K)  
    
    tr = a( 1 : (K-1)*fold_length ); 
    ts = a( ((K-1)*fold_length) + 1 : end );

else
    
    lower_bound_ts = (i-1) * fold_length + 1 ;
    upper_bound_ts = i * fold_length;
    ts = a( lower_bound_ts : upper_bound_ts ); 
    a1 = a ( 1 : lower_bound_ts-1 );
    a2 = a( upper_bound_ts+1 : end );
    tr = [ a1 ; a2 ];
end
 
tr = [tr ; randsubset(a,[1 1 1])];
ts = [ts ; randsubset(a,[1 1 1])];   

%-------------------------------------------------------------------------
%TEST
%-------------------------------------------------------------------------

%PERFORMANCE MEASURES
 Mperf = {...
         'mean-error', ...
         'err','Low', 'err','Medium', 'err','High' ...
         'TP','Low', 'FP','Low', 'TN','Low', 'FN','Low', ...
         'TP','Medium', 'FP','Medium', 'TN','Medium', 'FN','Medium', ...
         'TP','High', 'FP','High', 'TN','High', 'FN','High', ...
         'TPr','Low', 'FPr','Low', 'TNr','Low', 'FNr','Low', ...
         'TPr','Medium', 'FPr','Medium', 'TNr','Medium', 'FNr','Medium', ...
         'TPr','High', 'FPr','High', 'TNr','High', 'FNr','High', ...
         'precision','Low', 'precision','Medium', 'precision','High', ...
         'sensitivity','Low' , 'sensitivity', 'Medium', 'sensitivity','High', ...
         'specificity','Low' , 'specificity', 'Medium', 'specificity','High', ...
 };

result(i,1) = Performance_Evaluation_Default_Classifier(ts);
                        
%-------------------------------------------------------------------------
end

[avg_result mat_srucut] = Average_Result(result);


ACC  = avg_result(1,25);
ERR  = avg_result(1,26);
FS   = avg_result(1,33);
PRE  = avg_result(1,27);
REC  = avg_result(1,28);
SPE  = avg_result(1,29);
MCC  = avg_result(1,37);
GAIN = avg_result(1,41);

G_mean = avg_result(1,42);

%For AUC I think the following procedure is correct:
%1. AUC_Low:  FPr-TPr for Low:  for every threshold we have: FRr=0; TPr=o => AUC_Low=0
%2. AUC_Med:  FPr-TPr for Med:  for every threshold we have: FRr=0; TPr=o => AUC_Med=0
%3. AUC_High: FPr-TPr for High: for every threshold we have: 
%   FRr=(#Low+#Med)/n => (13+48)/113 = 0.54
%   TPr=#High/n => 52/113 = 0.46
%   => AUC_High = NaN, becuase for every threshold there is just 1 point at (0.54,0.46)
%4. Avg_AUC = (0 + 0 + NaN)/3

AUC = NaN;

sprintf('*** ACC=%0.2f ERR=%0.2f PRE=%0.2f REC=%0.2f SPE=%0.2f GAIN=%0.2f MCC=%0.2f FS=%0.2f AUC=%0.2f G-mean=%0.2f***', ...
ACC, ERR, PRE, REC, SPE, GAIN, MCC, FS, AUC, G_mean )     

%--------------------------------------------------------------------------
%Done!


   