%% Error Implementation Function
% This function computes a random space state error vector for implementing
% into a desired state point
%
% INPUT DATA
%   ss --> Initial state vector
%   xlim --> Position component error limit
%   vlim --> Velocity component error limit
%   n --> Error type
%       1 --> Tracking error
%       2 --> Maneuver execution error
%
% OUTPUT DATA
%   ss --> Final state vector
%
function[ss]=errImpl(ss,xlim,vlim,n)                                     % [Units]
%-------------------- VARIABLE INTIALIZATION ------------------------------
err=zeros(6,1); % Error vector intialization
%-------------------- ERROR VECTOR CALCULATION ----------------------------
if n==1
	%-------------------- TRACKING ERROR ----------------------------------
    for i=1:3
        err(i)=(2*rand-1)*xlim;	% Error vector position component calculation
        err(i+3)=(2*rand-1)*vlim;	% Error vector velocity component calculation
    end
elseif n==2
    %-------------------- MANEUVER EXECUTION ERROR ------------------------
    for i=4:6
        err(i)=(2*rand-1)*vlim(i);  % Error vector velocity component calculation
    end
end
    %----------------------------------------------------------------------
%-------------------- ERROR VECTOR IMPLEMENTATION -------------------------
ss=ss+err;  % Initial state vector perturbation
%--------------------------------------------------------------------------
end