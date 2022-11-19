
%--------------------------------------------------------------------------    
    clear all
    clc

    %1-Reading the file.
    fileName='D:\Dropbox\Thesis\Objective 2-Features Generation\Dataset_Hirose.xlsx';
    [~,Data,~]   = xlsread(fileName,'Data');
    [~,Vector,~] = xlsread(fileName,'Vector');
    [~,Strain,~] = xlsread(fileName,'Strain');

    %2-Keeping these columns: gene sequence, vector, strain, exp level.
    %Data after this step is a (numberOfRows*4) matrix.
    numberOfRows   = size(Data , 1);
    geneSeqColumn  = 2;
    %vectorColumn  = 3;
    strainColumn   = 4;
    expLevelColumn = 5;


    Data = [...
            Data(2:numberOfRows , geneSeqColumn:strainColumn)...
            Data(2:numberOfRows , expLevelColumn)...
           ];

    %3-Finding the most common (most frequent) values for vector, strain 
    %and exp level columns.
    commonVector   = ModeStr( Data(:,2),'?' );
    commonStrain   = ModeStr( Data(:,3),'?' );
    %commonExpLevel = ModeStr( Data(:,4),'?' );

    %4-Replacing the missing values: replacing the '?' by the most common 
    %values for vector, strain and exp level columns.
    Data(:,2) = ReplaceStrInArray(Data(:,2),'?',commonVector);
    Data(:,3) = ReplaceStrInArray(Data(:,3),'?',commonStrain);
    %Data(:,4) = ReplaceStrInArray(Data(:,4),'?',commonExpLevel);
    Data(:,4) = ReplaceStrInArray(Data(:,4),'?','Medium');

    %5-Replacing the vector and strain values by their numerical values.
    NumericalVectorValue   = ReplaceByNumericalValue(Data(:,2),Vector);
    NumericalStrainValue   = ReplaceByNumericalValue(Data(:,3),Strain);
    
    %6-Feature generation from GeneSequence column.
    geneSeqFeatures = Generate_Gene_Seq_Features_ChanHirose();

    %7-Saving the processed data in the form of perClass input.
    samples_original = [NumericalVectorValue , NumericalStrainValue , geneSeqFeatures];
    labels = char( Data(:,4) );

    %8-Data normalization: columns of "samples" have mean 0 and scaled to have
    %standard deviation 1.
    samples_normalized = zscore(samples_original);
    
    %9-Data scaling: liner transformation.
    samples_scaled = zeros(size(samples_normalized,1),size(samples_normalized,2));
    
    for i=1:size(samples_normalized,2)
        
        Xmin = min( samples_normalized(:,i) );
        Xmax = max( samples_normalized(:,i) );
        samples_scaled(:,i) = (samples_normalized(:,i)-Xmin) / (Xmax-Xmin);
        
    end 
    
    samples = samples_scaled;
    
    %ToDo: I removed a record in the Dataset with ID=EC0070 (or ID=EC0072) 
    %because of having just 3 NaNs! After finalizing the features, if it 
    %occured again for the other features, it is not wise to repeat this for 
    %the records with just afew NaN values! In that case, restore the deleted 
    %record, and compute the zscore without considering the NaN values. 
    %The sample is on the internet!
   
    
    save('data_ChanHirose.mat', 'samples', 'labels');

    %Done!
    
%--------------------------------------------------------------------------    
