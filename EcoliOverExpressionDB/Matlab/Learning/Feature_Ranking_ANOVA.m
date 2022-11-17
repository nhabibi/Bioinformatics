function [ selected_features_idx ] = Feature_Ranking_ANOVA( samples , labels)
%------------------------------------------------------------------------
%The statistically significant difference between the 3 classes was calculated for each of the features. The features 
%were counted as related with protein solubility/expression if p < 0.05. 

%[h,p,ci,stat] = ttest2(samplesLow, samplesMed, [], [], 'unequal');

%------------------------------------------------------------------------
number_of_features = size(samples,2);
p_value_s = zeros(1,number_of_features);

for i=1:number_of_features
   
    [p,~,~] = anova1( samples(:,i) , labels , 'off' );
    p_value_s(i) = p;
           
end

selected_features_idx = find(p_value_s < 0.05);
%related_feats_p_values = p_value_s( selected_features_idx );

%hist( p_value_s( 1 , 1:number_of_features ) );
%legend('Histogram of p-values of features');

%--------------------------------------------------------------------------

