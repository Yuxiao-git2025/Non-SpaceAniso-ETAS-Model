%%                                         || Data loading ||
 % Before do this, run the ST-ETAS for parameter-preparation
global SaveID
assert(~isempty(SaveID),'Run Config or Main1_ST to set ID.');
STFile=fullfile(ResultDir,['ST_Results',num2str(SaveID),'.mat']);
Fit=load(STFile,'Result','Catalog');
Catalog=Fit.Catalog;


%%                                   || Running HIST-ETAS ||
% Spatial fields: [mu,K,alpha,p,q]. The ST fit supplies the baseline.
[Result,Mesh,ST,geom]=Hist_ETASModel(Catalog,Fit.Result,Bi2,TuneWeights,MaxIter);



%%                                   || Plotting and Results ||
IsSave=0;
Hist_OutputMapping(Catalog,geom,Result,Mesh,PlotDir,IsSave);
% ST_Residual(Catalog,ST,PlotDir,'ST_Hist_Comparison',Result,IsSave);
if IsSave
    save(fullfile(ResultDir,['Hist_Results',num2str(SaveID),'.mat']),'Result','Catalog','Mesh','ST');
end

