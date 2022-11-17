 
[avg_result, mat_struct] = Average_Result(result);

ACC  = avg_result(1,29);
ERR  = avg_result(1,30);
FS   = avg_result(1,37);
PRE  = avg_result(1,31);
REC  = avg_result(1,32);
SPE  = avg_result(1,33);
MCC  = avg_result(1,41);
GAIN = avg_result(1,45);
G_mean = avg_result(1,46);

AUC = mean(area_under_curve);
%AUC = NaN;

%sprintf('*** ACC=%0.2f ERR=%0.2f PRE=%0.2f REC=%0.2f SPE=%0.2f GAIN=%0.2f MCC=%0.2f FS=%0.2f AUC=%0.2f G-mean=%0.2f***', ...
%ACC, ERR, PRE, REC, SPE, GAIN, MCC, FS, AUC, G_mean )

%--------------------------------------------------------------------------

%Computing 95% confidence intervals for the measurments
ACC_s = mat_struct(:,29);     pd = fitdist(ACC_s,'Normal');     CI_ACC = paramci(pd);
ERR_s = mat_struct(:,30);     pd = fitdist(ERR_s,'Normal');     CI_ERR = paramci(pd);
FS_s = mat_struct(:,37);      pd = fitdist(FS_s,'Normal');      CI_FS = paramci(pd);
PRE_s = mat_struct(:,31);     pd = fitdist(PRE_s,'Normal');     CI_PRE = paramci(pd);
REC_s = mat_struct(:,32);     pd = fitdist(REC_s,'Normal');     CI_REC = paramci(pd);
SPE_s = mat_struct(:,33);     pd = fitdist(SPE_s,'Normal');     CI_SPE = paramci(pd);
MCC_s = mat_struct(:,41);     pd = fitdist(MCC_s,'Normal');     CI_MCC = paramci(pd);
GAIN_s = mat_struct(:,45);    pd = fitdist(GAIN_s,'Normal');    CI_GAIN = paramci(pd);
G_mean_s = mat_struct(:,46);  pd = fitdist(G_mean_s,'Normal');  CI_G_mean = paramci(pd);
AUC_s = (area_under_curve);   pd = fitdist(AUC_s,'Normal');     CI_AUC = paramci(pd);

%--------------------------------------------------------------------------

sprintf(' ACC    = %0.2f +- %0.2f \n ERR    = %0.2f +- %0.2f \n FS     = %0.2f +- %0.2f \n PRE    = %0.2f +- %0.2f \n REC    = %0.2f +- %0.2f \n SPE    = %0.2f +- %0.2f \n MCC    = %0.2f +- %0.2f \n GAIN   = %0.2f +- %0.2f \n G-mean = %0.2f +- %0.2f \n AUC    = %0.2f +- %0.2f \n', ...   
ACC, (CI_ACC(2,1)-CI_ACC(1,1))/2          , ...
ERR,(CI_ERR(2,1)-CI_ERR(1,1))/2           , ...
FS, (CI_FS(2,1)-CI_FS(1,1))/2             , ...
PRE, (CI_PRE(2,1)-CI_PRE(1,1))/2          , ...
REC, (CI_REC(2,1)-CI_REC(1,1))/2          , ...
SPE, (CI_SPE(2,1)-CI_SPE(1,1))/2          , ...
MCC, (CI_MCC(2,1)-CI_MCC(1,1))/2          , ...
GAIN, (CI_GAIN(2,1)-CI_GAIN(1,1))/2       , ...
G_mean, (CI_G_mean(2,1)-CI_G_mean(1,1))/2 , ...
AUC, (CI_AUC(2,1)-CI_AUC(1,1))/2          ) 


%-------------------------------------------------------------------------
%To plot just the last ROC as a sample.
% sddrawroc(r_Low);
% sddrawroc(r_Med);
% sddrawroc(r_High);

%--------------------------------------------------------------------------
%Done!

