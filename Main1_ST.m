%%                                || Load the Configuration File ||
% Written by XA.Yu (2026/11/20)
% If there are any errors or bugs, please contact me at: XAYu2026@outlook.com
                                           Config

%%                              || Running Anisotropic ST-ETAS ||
% Estimate clusters retrospectively, then select the fitting catalog.
[Catalog,geom]=ST_Prepare(time,mag,lon,lat,Mmin,R,T0,T1, ...
    ClusterMin=ClusterMin,ClusterDays=ClusterDays,ClusterEnd=Inf);
Catalog.EventID=Data(Catalog.Index,1);
Result=ST_Fit(geom); % Start Fitting
fprintf('ST-ETAS: %d target/%d events\n    %d ellipses, LL = %.3f, AIC = %.3f\n', ...
    numel(Result.In),numel(Catalog.time),nnz(Catalog.Case>=2), Result.LL,Result.AIC);
fprintf('    Baseline (mu,K,c,alpha,p,d,q)\n');
disp(Result.paramNew);



%%                               || Plotting and Results ||
% Save and plot
IsSave=0;
ST_OutputMapping(Catalog,Result,PlotDir,IsSave);
if IsSave
    save([ResultDir,'/ST_Results',num2str(SaveID),'.mat'],'Result','Catalog');
end
