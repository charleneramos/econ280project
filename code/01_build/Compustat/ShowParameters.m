% ShowParameters.m
%
%  Show the key parameters for the Computstat IdeaPF project

disp ' ';
disp '=============================================================';
disp ' ';
disp(['KEY PARAMETER VALUES:    CaseName = ' CaseName]);;
disp([  '         Idea Output Measure = ' OutputMeasure]);
fprintf('            DotComCorrection =%6.0f\n',DotComCorrection);
fprintf('       WeightingByScientists =%6.0f\n',WeightingByScientists);
fprintf('  RequireAllDecadesPosGrowth =%6.0f\n',RequireAllDecadesPosGrowth);
fprintf(' RequireIncreasingScientists =%6.0f\n',RequireIncreasingScientists);
fprintf('           MinimumGrowthRate =%8.4f\n',MinimumGrowthRate);
fprintf('               WindsorizeTop =%6.0f\n',WindsorizeTop);
fprintf('              DHSGrowthRates =%6.0f\n',DHSGrowthRates);
disp([  '          IdeaGrowthApproach = '  IdeaGrowthApproach]);
if strcmp(SampleFrame,'Baseline');
    disp ' ';
    disp '         This is the baseline sampling frame:';
    disp '          - 2 consecutive decades of postive MktCap/Sales/EmpGrowth';
    disp '          - But no requirement that effective scientists increase between the two';
elseif strcmp(SampleFrame,'Robust1');
    disp ' ';
    disp '         This is the first robustness case:  (smaller sample than benchmark)';
    disp '          - 2 consecutive decades of postive MktCap/Sales/EmpGrowth';
    disp '          - AND Increasing effective scientists between the two decades';
elseif strcmp(SampleFrame,'Robust2');
    disp ' ';
    disp '         This is the second robustness case:  (smaller sample than benchmark)';
    disp '          - 2 consecutive decades of postive MktCap/Sales/EmpGrowth';
    disp '          - But no requirement that effective scientists increase between the two';
    disp '          - AND drop if *any* decade has negative MktCap/Sales/EmpGrowth';
end;
disp ' ';
disp '=============================================================';
disp ' ';
