%%%%%%%%%%%%%%%%%%%%%%%%%%%
% COMPREWARDS.m
%
% DESCRIPTION
%   Computes a reward given a state and action
%
% AUTHOR
%   Trevor Squires
%
% INPUT
%   state - state at time t
%   action - innings played for each pitcher at time t
%   winProb - win probabilities for pitchers under medium rest
%   k - number of innings
%
% OUTPUT
%   reward - reward of action
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [reward] = compReward(state,action,winProb,k)

effWinProb = actualWinProb(winProb,state,action);
totWinProb = sum(action.*effWinProb)/k;
reward = totWinProb;
end