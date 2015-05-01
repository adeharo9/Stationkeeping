%% Cross Detection Function
% This function calculates the points where a spacecraft crosses one of the
% three main planes of the reference system
%
% INPUT DATA
%   ss --> Orbit states vector
%   d --> Tolerance for crossings
%
% OUTPUT DATA
%   ssc --> Orbit states at crossing
%   p --> Plane of crossing
%       xy --> z=0
%       xz --> y=0
%       yz --> x=0
%
function[ssc]=crossDetect(ss,p)                                          % [Units]
%-------------------- CROSSING PLANE DETERMINATION ------------------------
if ~exist('p','var')
    d=2;    % Crossings on XZ plane
else
    if strcmp(p,'xy')
        d=3;	% Crossings on XY plane
    elseif strcmp(p,'xz')
        d=2;    % Crossings on XZ plane
    elseif strcmp(p,'yz')
        d=1;    % Crossings on YZ plane
    end
end
%-------------------- VARIABLE INITIALIZATION -----------------------------
n=numel(ss(1,:));   % Number of state points
ssc=zeros(6,1);	% Crossings variable initialization
%-------------------- CROSSING CALCULATION --------------------------------
for i=2:n-1
    if (sign(ss(d,i))+sign(ss(d,i+1)))==0
        if abs(ss(d,i))<abs(ss(d,i+1))
            ssc=ss(:,i);   % Crossing point assignation
        else
            ssc=ss(:,i+1); % Crossing point assignation
        end
    end
end
%--------------------------------------------------------------------------
end