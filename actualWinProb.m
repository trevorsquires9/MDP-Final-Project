%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ACTUALWINPROB.m
%
% DESCRIPTION
%   Returns win probability of each pitcher under any state given the win
%   probability in a medium state
%
% AUTHOR
%   Trevor Squires
%
% INPUT
%   winProb - vector of win probabilities under medium rest
%   state - vector of state of pitchers
% OUTPUT
%   actualWinProb - win probabity of each pitcher given his rest state
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [actualWinProb] = actualWinProb(winProb,state)
actualWinProb = zeros(1,length(state));
k = 10;
for i = 1:length(state)
    if state(i) == 0
        actualWinProb(i) = winProb(i)^k;
        
    elseif state(i) == 1
        actualWinProb(i) = winProb(i);
        
    else
        actualWinProb(i) = winProb(i)^(1/k);
    end
end