%% Reference Orbit Point Match Calculator
% This function calculates the point at the reference orbit that is at the
% same time from the initial state as the crossing point in the perturbed
% orbit
%
% INPUT DATA
%   t --> Time vector of the perturbed orbit
%   ssc --> State vector of crossing
%   ss --> Perturbed orbit state vector of points
%   ssr --> Reference orbit state vetor of points
%
% OUTPUT DATA
%   ssrp --> State vector of point in the reference orbit
%   tf --> Final time
%   
function[tf,ssrp]=refOrbPoint(t,ssc,ss,ssr)                              % [Units]
%-------------------- PERTURBED ORBIT INDEX SEARCH ------------------------
for i=1:3
    k=find(ssc(i)==ss(i,:));    % Index of crossing point in perturbed orbit
    ka=find(ssc(i+3)==ss(i+3,:));   % Index of crossing point in perturbed orbit
    if numel(k)==1
        if k~=ka
            error('Point not found');   % Error for no-matching condition
        end
    else
        if sum(k==ka)==0
            error('Point not found');   % Error for no-matching condition
        end
    end
end
%-------------------- FINAL TIME DETERMINATION ----------------------------
tf=t(k);  % Final time
%-------------------- REFERENCE ORBIT INDEX CALCULATION -------------------
n=round(tf/1e-4); % Index of crossing point in reference orbit
%-------------------- REFERENCE ORBIT STATE VECTOR ------------------------
ssrp=ssr(:,n);  % Equivalent point in reference orbit
%--------------------------------------------------------------------------
end