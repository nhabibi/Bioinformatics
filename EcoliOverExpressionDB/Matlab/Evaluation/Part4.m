
%Draw the Error vs. Number of tree

% RF = TreeBagger(5000, samples, labels, 'OOBPred','on');
% 
% error = oobError(RF);
% plot( error );
% xlabel('Number of Trees');
% ylabel('Out-of-bag Classification Error');
% 
% [min_val min_index] = min(error)

%--------------------------------------------------------------------------   
%Draw the Error vs. Number of random variables taken.

optimal_number_of_features = Learning_Curve_RF_Features_Number(a);

%--------------------------------------------------------------------------   
