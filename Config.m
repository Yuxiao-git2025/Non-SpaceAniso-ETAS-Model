% =====================================================
%                                           Parameters
% clear global;
% clear Root;
global SaveID
SaveID=3; % Check-ID (Before calculation, mark a ID for each working)
Root='/Users/Yu/Ymat/MyStatisticFunc/NonHistETAS';
ResultDir=fullfile(Root,'Results');
PlotDir=fullfile(Root,'plot');
Mmin=5;                              % Minimum magnitude (i.e., Mc)
ClusterMin=6.5;                   % Minimum magnitude to start a cluster (i.e., candidate mainshocks)
ClusterDays=10;                    % Aftershock search window in days
R=[128 30;149 30;149 47;128 47];   % Region vertices [lon,lat] in degrees (e.g, four points)
% R=[min(lon) min(lat)
%     max(lon) min(lat)
%     max(lon) max(lat)
%     min(lon) max(lat)
%     ];
T0=9000;
T1=11000;                 % Fitting window in catalog days
Ts=7000;                    % Starting-time when triggering events (0 keeps all; 0<=Ts<=T0)
% Extra-Params
TuneWeights=false;  % Optimize the five spatial smoothing weights
Bi2=2;                      % Triggering-pair radius multiplier (Inf keeps all pairs)
MaxIter=1200;         % Maximum iterations per penalized fit
% =====================================================
%                                           Data loading
Data=readmatrix('Data/Work.etas','FileType','text','NumHeaderLines',1);

% Keep only events at or after Ts. This removes very old triggering sources
% Ts must satisfy 0 <= Ts <= T0;  Set Ts=0 to keep the full catalog.
Data=Data(Data(:,5)>=Ts,:); time=Data(:,5); mag=Data(:,4); lon=Data(:,2); lat=Data(:,3);

% =====================================================
% Info
clc; warning off;
fprintf('# Data (%d events; Ts =%.1f) already loaded now\n',numel(time),Ts);
fprintf('  %s\n\n',datetime('now'));

% Quick M-T view: gray Ts-T0 history window, blue T0-T1 target
% window, and cumulative count on the right axis.
ST_PlotMT(time,mag,Ts,T0,T1,Mmin);
