%% Main Control Script
% This script computes the control environment of a spacecraft performing
% stationkeeping maneuvers
%
%-------------------- INITIAL CHECK ---------------------------------------
close all;  % Closing of windows
clear all;  % Cleaning of workspace
clc;    % Cleaning of command window
%-------------------- DATA LOAD -------------------------------------------
haloFam=4;  % Halo Family
numb=3; % Size number
path=['./Reference Orbits/HaloFamily_',num2str(haloFam),'_numb_',num2str(numb),'.mat']; % Path of data storage
load(path); % Load of data
clearvars -except orbitStates revperiod;    % Cleaning of useless variables
%-------------------- INITIAL DATA ----------------------------------------
t0=0;   % Initial time
n=5;    % Number of revolutions
xlim=2.601456815816858e-06; % Maximum position error (1000 m)
vlim=9.760734242631965e-06; % Maximum velocity error (0.01 m/s)
mu=0.01215; % Mass parameter
%-------------------- ORBIT COMPUTATION -----------------------------------
    %-------------------- INITIAL POINT ERROR APPLICATION -----------------
ss0=orbitStates(:,1);   % Initial state
ss0=errImpl(ss0,xlim,vlim,1);   % Initial state tracking error application

plot3(orbitStates(1,:),orbitStates(2,:),orbitStates(3,:));
hold on;
grid on;

for i=1:2*n
    %-------------------- PERTURBED ORBIT PROPAGATION ---------------------
    tf=t0+1.25*revperiod(ceil(i/2))/2;   % Final time until maneuver
    [t,ss]=CR3BP(ss0,mu,t0,tf); % Perturbed point propagation
    %-------------------- CALCULATION OF MANEUVER LOCATION ----------------
    ssc=crossDetect(ss);    % XZ plane crossing detection
    %-------------------- ERROR VECTOR COMPUTATION ------------------------
    [tf,ssrp]=refOrbPoint(t,ssc,ss,orbitStates); % Reference orbit equivalent point calculation
    ssc=errImpl(ssc,xlim,vlim,1);   % Crossing point tracking error
    d=ssc-ssrp;	% Error vector calculation
    %-------------------- CONTROL ALGORITHM -------------------------------
    Av=[0;0;0;1e-3;0;0];	% Maneuver calculation
    %-------------------- MANEUVER EXECUTION ------------------------------
    Av=errImpl(Av,0,0.01*Av,2); % Maneuver execution error
    ss0=ssc+Av; % Maneuver execution
    t0=tf;  % New initial time
    
    plot3(ss(1,1:find(t==tf)),ss(2,1:find(t==tf)),ss(3,1:find(t==tf)),'Color','r');
    plot3(ssc(1,:),ssc(2,:),ssc(3,:),'*','Color','r');
    plot3(ssrp(1,:),ssrp(2,:),ssrp(3,:),'*');
end
    %----------------------------------------------------------------------
%--------------------------------------------------------------------------