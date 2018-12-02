%%%%%%%%%%%%%%%%%%%%%%%%%%%
% GETWINPROB.m
%
% DESCRIPTION
%   Returns win probability of each pitcher under medium rest
%
% AUTHOR
%   Trevor Squires
%
% OUTPUT
%   winProb - 1 x 5 vector of win probabilities for each pitcher
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [winProb] = getWinProb()
era = [2.85, 3.9, 3.94, 4.29 2.85]; %mean runs per game
sd = [2.4, 2.8, 2.4, 2.9, 2.9]; %standard deviation of runs per game
zScore = (era-4.62)./sd; %4.62 is Atlanta's average runs per game

winProb = normcdf(zScore,0,1,'upper');
end
