function [ result ] = Learning_Curve_RF_Features_Number( data )
%data: perClass sddata
%--------------------------------------------------------------------------
%Learning Curve: mean-error vs. Number of random variables taken
%--------------------------------------------------------------------------        
    
    repeat = 20;
    number_of_features = size(data,2);

    for i=1:repeat
        
        sprintf('Learning curve round=%d',i)
        
        [train,cv] = randsubset(data,0.75);
        
        for j=1:number_of_features
            j
            
            %Select j features randomly among all the features.
            perm_features = randperm(number_of_features);
            rand_features = perm_features(1:j);
            
            sub_features_train = train(:, rand_features , :);
            sub_features_cv    = cv(:, rand_features , :);
            
            p =  sdrandforest( sub_features_train , 'trees',100 , 'dim',j );
            
            perf_train(i,j) = sdtest(p,sub_features_train);
            perf_cv(i,j) = sdtest(p,sub_features_cv);

        end

    end

    mean_perf_train = mean(perf_train);
    mean_perf_cv = mean(perf_cv);

    plot( (1:number_of_features) , mean_perf_train , 'ob' , (1:number_of_features) , mean_perf_cv , '*r' );
    
    hleg = legend('Train','CV');
    set(hleg,'Location','NorthEast')

    xlabel('Number of Features');
    ylabel('Mean-error');
    title('Learning curve');
        
    [~ , result] = min(mean_perf_cv);
     
%--------------------------------------------------------------------------
end

