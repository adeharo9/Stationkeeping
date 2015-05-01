%% Circular Restricted Three Body Problem
% This script computes the solution for the Circular Restricted Three Body
% Problem (CR3BP) given a initial state vector
%
% INPUT DATA
%   ss0 --> Initial state vector
%   mu --> Mass parameter
%   t --> Time of simulation
%
% OUTPUT DATA
%   ss --> Orbit state points
%
function[t,ss]=CR3BP(ss0,mu,t0,tf)                                       % [Units]
%-------------------- INITIAL CONDITIONS ----------------------------------
T=[t0,tf];	% Time of simulation vector
inicond=ss0;	% Initial state vector
opt=odeset('RelTol',1e-8,'AbsTol',1e-10);	% Solution tolerances
%-------------------- SYSTEM SOLUTION -------------------------------------
[t,ss]=ode45(@(t,ss)diffEqSys(ss,mu),T,inicond,opt);	% ODE system resolution
ss=ss';	% ODE solution vector transpose
%--------------------------------------------------------------------------
end
%% Differential equations system definition
% This function defines the differential equations system to be solved by
% ODE45 in state space form
%
% INPUT DATA
%   ss --> Adimensional state space vector of variables in the form:
%       ss(1)=u
%       ss(2)=v
%       ss(3)=w
%       ss(4)=du
%       ss(5)=dv
%       ss(6)=dw
%   mu --> Mass ratio
%
% OUTPUT DATA
%   dssdt --> Adimensional state space vector of solutions in the form:
%       dssdt(1)=Du
%       dssdt(2)=Dv
%       dssdt(3)=Dw
%       dssdt(4)=D2u
%       dssdt(5)=D2v
%       dssdt(6)=D2w
%
function[dssdt]=diffEqSys(ss,mu)                                         % [Units]
%-------------------- AUXILIARY VARIABLES ---------------------------------
d1=sqrt((ss(1)+mu)^2+ss(2)^2+ss(3)^2); % Distance to 1st primary
d2=sqrt((ss(1)-1+mu)^2+ss(2)^2+ss(3)^2);    % Distance to 2nd primary
%-------------------- DIFFERENTIAL EQUATIONS SYSTEM -----------------------
Du=ss(4);   % X-velocity
Dv=ss(5);   % Y-velocity
Dw=ss(6);   % Z-velocity
D2u=-(1-mu)*(ss(1)+mu)/d1^3-mu*(ss(1)-1+mu)/d2^3+ss(1)+2*ss(5); % X- acceleration
D2v=-(1-mu)*ss(2)/d1^3-mu*ss(2)/d2^3+ss(2)-2*ss(4); % Y-acceleration
D2w=-(1-mu)*ss(3)/d1^3-mu*ss(3)/d2^3;   % Z-acceleration
%-------------------- SOLUTION VECTOR -------------------------------------
dssdt=[Du;Dv;Dw;D2u;D2v;D2w];   % Solution vector
%--------------------------------------------------------------------------
end