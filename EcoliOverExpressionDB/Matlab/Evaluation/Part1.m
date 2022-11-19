clear all

load('data_ChanHirose.mat');

a = sddata(double(samples) , labels);

%--------------------------------------------------------------------------
% PCA
%--------------------------------------------------------------------------
%First, we have to rewmove the columns which are NaN, becuase "Matlab princomp" dose not accept them.
% number_of_samples  = size(samples,1);
% number_of_features = size(samples,2);
% 
% samples_without_NaN = [];
% for i=1:number_of_features
%     
%     next_feature = samples(:,i);
%     NaNs = isnan( next_feature );
%     if( sum(NaNs)==0 )%it means no NaN in the column
%         samples_without_NaN =[samples_without_NaN , next_feature];
%     end
%     
% end
% samples_without_NaN = samples_without_NaN(:,2:end);
% 
% 
% pca_samples = Feature_Extraction_PCA(samples_without_NaN);
% 
% a = sddata(double(pca_samples) , labels);

%--------------------------------------------------------------------------
% ANOVA
%--------------------------------------------------------------------------
selected_features_idx = Feature_Ranking_ANOVA(samples , labels);

a = a(:,selected_features_idx);
samples = samples(:,selected_features_idx);

%--------------------------------------------------------------------------
% WRAPPER
%--------------------------------------------------------------------------
%[p_feat rest_feat] = sdfeatsel(a, 'method' , 'forward');
%[p_feat rest_feat] = sdfeatsel(a, 'method' , 'backward');
%[p_feat rest_feat] = sdfeatsel(a, 'method' , 'random');
%[p_feat rest_feat] = sdfeatsel(a, 'method' , 'floating');

%a = a * p_feat;

%--------------------------------------------------------------------------
% EMBEDDED
%--------------------------------------------------------------------------
% selected_features_idx = Feature_Ranking_Embedded(a , samples , labels);
%   
% a = a(:,selected_features_idx);

%--------------------------------------------------------------------------
% ANOVA=>Forward
%--------------------------------------------------------------------------
% selected_features_idx = Feature_Ranking_ANOVA(samples , labels);
% a = a(:,selected_features_idx);
%   
% [p_feat rest_feat] = sdfeatsel(a, 'method' , 'forward');
% a = a*p_feat;

%--------------------------------------------------------------------------
% ANOVA=>RF
%--------------------------------------------------------------------------
% selected_features_idx = Feature_Ranking_ANOVA(samples , labels);
% a       = a(:,selected_features_idx);
% samples = samples(: , selected_features_idx);
% 
% selected_features_idx = Feature_Ranking_RF(a , samples , labels);
% a = a(:,selected_features_idx);

%--------------------------------------------------------------------------
% Forward=>RF
%--------------------------------------------------------------------------
% [p_feat rest_feat] = sdfeatsel(a, 'method' , 'forward');
% a = a*p_feat;
% samples =  samples(: , rest_feat.best_subset);
% 
% selected_features_idx = Feature_Ranking_RF(a , samples , labels);
% a = a(:,selected_features_idx);

%--------------------------------------------------------------------------
% RF=>Forward
%--------------------------------------------------------------------------
% selected_features_idx = Feature_Ranking_RF(a , samples , labels);
% a = a(:,selected_features_idx);
% 
% [p_feat rest_feat] = sdfeatsel(a, 'method' , 'forward');
% a = a*p_feat;

%--------------------------------------------------------------------------





