%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TRANSITIONPROB.m
%
% DESCRIPTION
%   Given a pitchers rest level, and innings played, returns the
%   probability of a pitcher reaching a given state
%
% AUTHOR
%   Trevor Squires
%
% INPUT
%   src - initial rest level
%   action - innings played
%   dest - final rest level
%
% OUTPUT
%   probability - probability of starting in state src and ending in state
%   dest
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [probability] = transitionProb(src,action,dest)

P = [((action+0.1)/9.1)^(1/5) 0 0.2*((9-action)/9)^5; 0.75*(action/9)^2 0 0.5*(1-(action/9)^(1/2)); 0.5*(action/9)^(1/3) 0 1-(action/9)^(1/3)];

for i = 1:3
    P(i,2) = 1-sum(P(i,:));
end
probability = P(src+1,dest+1);
end