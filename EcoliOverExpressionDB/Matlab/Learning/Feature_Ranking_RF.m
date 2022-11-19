function [ selected_features_idx ] = Feature_Ranking_RF(data , samples , labels)
%-------------------------------------------------------------------------
%Here I am using the internal mechanism of RF to rank the features, implemented by Matlab TreeBagger function:

RF = TreeBagger(100, samples, labels, 'OOBVarImp','on')
          
variable_importances = RF.OOBPermutedVarDeltaError;
%negative_importances = size( find(variable_importances < 0) , 2 );

[~, idx] = sort(variable_importances , 'descend');

%-------------------------------------------------------------------------
%%Learning curve: mean-error vs. increasing number of the best features.
%-------------------------------------------------------------------------

repeat = 20;
number_of_features = size(variable_importances,2);

for i=1:repeat
       
        sprintf('Embedded ranking round=%d',i)
        
        [train,cv] = randsubset(data,0.75);
        sub_features_train = [];
        sub_features_cv = [];
        
        for j=1:number_of_features
            
         sub_features_train = [ sub_features_train , train(: , idx(1,j) , :) ];
         sub_features_cv    = [ sub_features_cv , cv(: , idx(1,j) , :) ];
            
         %----------------------------Train--------------------------------
         p = sdknn(sub_features_train);                 
         %----------------------------Test---------------------------------
         perf_train(i,j) = sdtest(p,sub_features_train);
         perf_cv(i,j) = sdtest(p,sub_features_cv);

       end
end

mean_perf_train = mean(perf_train);
mean_perf_cv = mean(perf_cv);

plot( (1:number_of_features) , mean_perf_train , 'ob' , (1:number_of_features) , mean_perf_cv , '*r' );

hleg = legend('Train','CV');
set(hleg,'Location','NorthEast')

xlabel('Number of best features selected by RF classifier');
ylabel('Mean-error');
title('Learning Curve');


[~ , best_size] = min(mean_perf_cv);
selected_features_idx = idx(1:best_size);
 
%--------------------------------------------------------------------------
end