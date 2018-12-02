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
k = 100;
for i = 1:length(state)
    actualWinProb(i) = (winProb(i)+(k-1)/2*state(i))/k;
end
end