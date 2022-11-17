
% For Leave-One-Out 
% number_of_data = size(a,1);
% n = number_of_data;
% K = number_of_data;
% fold_length = floor(n/K);
%--------------------------------------------------------------------------

%For K-fold
number_of_data = size(a,1);
n = number_of_data;
K = 10;
fold_length = floor(n/K);
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
%TRAIN
%-------------------------------------------------------------------------
%p = sdtree(tr)
%p = sdnbayes(tr)
%p = sdneural(tr, 'noscale')
%p = sdsvc(tr, 'type','poly', 'noscale')
%p = sdrandforest(tr)
p = sdrandforest(  tr, 'count', 233, 'dim',sqrt(size(tr,2)) )

pfinal = p;

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

performance = sdtest( pfinal , ts , 'measures' , Mperf );

result(i,1) = Performance_Evaluation(performance , ts);

                         %-----------------------%
%AUC: Method one-vs-all

Mroc_Low = {'FPr','Low','TPr','Low' };
r_Low = sdroc( ts , pfinal , 'measures',Mroc_Low );

Mroc_Med = {'FPr','Medium','TPr','Medium' };
r_Med = sdroc( ts , pfinal , 'measures',Mroc_Med );

Mroc_High = {'FPr','High','TPr','High' };
r_High = sdroc( ts , pfinal , 'measures',Mroc_High );

area_under_curve(i,1) = mean( [auc( r_Low ) , auc( r_Med ), auc( r_High )] );

%-------------------------------------------------------------------------
end

