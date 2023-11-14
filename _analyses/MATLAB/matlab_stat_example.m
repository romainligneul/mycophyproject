clear all

folder_stats_json='../stats';
%% t-test example
clear test
load stockreturns
x = stocks(:,3);
[test.h,test.p,test.ci,test.stats] = ttest(x);
% save the test as json
testname='ttest_stock';
encodedStats=jsonencode(test);
fid = fopen([folder_stats_json '\' testname '.json'],'w');
fprintf(fid,'%s',encodedStats);
fclose(fid);

%% anova example
clear test
load hogg
hogg
[test.p,test.tbl,test.stats] = anova1(hogg,[],'off');

% save the test as json
testname='anova_hogg';
encodedStats=jsonencode(test);
fid = fopen([folder_stats_json '\' testname '.json'],'w');
fprintf(fid,'%s',encodedStats);
fclose(fid);

%% anova example
% json is very flexible but it does not like the tables returned by
% matlab's anova functions (who does?), so we adjust a bit the output
clear test
load hogg
hogg
[test.p,tbl,test.stats] = anova1(hogg,[],'off');
test.stats.df1=cell2mat(tbl(2,3));
test.stats.F=cell2mat(tbl(2,5));

% save the test as json
testname='anova_hogg3';
encodedStats=jsonencode(test);
fid = fopen([folder_stats_json '\' testname '.json'],'w');
fprintf(fid,'%s',encodedStats);
fclose(fid);

%% text and table export example
% Often, you might run statistical test that a quite specific and
% non-standard, and you might be interested only in specific terms, such as
% an interaction term.
% In these cases, it might be worth writing down directly some text from
% Matlab (or whichever analysis language you're using.
clear test
load mfr
glme = fitglme(mfr,...
'defects ~ 1 + newprocess + time_dev + temp_dev + supplier + (1|factory)',...
'Distribution','Poisson','Link','log','FitMethod','Laplace',...
'DummyVarCoding','effects')

outputStr=sprintf('(beta(%.0f)=%.2f, p=%.4f)',glme.Coefficients.DF(4),glme.Coefficients.Estimate(4),glme.Coefficients.pValue(4))
test.newprocess=outputStr;

outputStr=sprintf('(beta(%.0f)=%.2f, p=%.4f)',glme.Coefficients.DF(3),glme.Coefficients.Estimate(3),glme.Coefficients.pValue(3))
test.time_dev=outputStr;

testname='text_glmeExample';
encodedStats=jsonencode(test);
fid = fopen([folder_stats_json '\' testname '.json'],'w');
fprintf(fid,'%s',encodedStats);
fclose(fid);

