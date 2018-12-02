%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MDP Final Project - Optimal Pitching
%
% DESCRIPTION
%   Determines the optimal way to play pitchers in the long term scenario
%   under a number of assumptions
%
% AUTHOR
%   Trevor Squires
%
% FUNCTION DEPENDENCIES
%   allActions.m
%
% PITCHERS
%   The brave's pitchers that I chose were:
%       Mike Foltynewicz
%       Sean Newcomb
%       Julio Teheran
%       Sam Freeman
%       Shane Carle
%
% WINNING PERCENTAGE
%   I chose to approximate average winning percentages based on ERA.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear
clc
close all;

%% Initialization of variables
n = 5;
k = 9;
lambda = 0.95;
numStates = 3^n; %each pitcher can be in either "tired","medium", or "rested"
actions = allActions(n,k); %number of possible ways we can play each pitcher per game
numActions = length(actions);
winProb = getWinProb();
err = 5;
tol = 1e-7;

%% Choose Initial Policy
d = zeros(numStates,n);
for i = 1:numStates
    d(i,:) = actions(1,:);
end

rewards = zeros(numStates,1);
for i = 1:numStates
    myState = index2state(i,n);
    rewards(i) = compReward(myState,d(i,:),winProb,k);
end

%% Policy Evaluation;
while err > tol
    P = zeros(numStates);
    for i = 1:numStates %for each state, need to compute probability of reaching any other state
        action = d(i,:);
        srcState = index2state(i,n);
        for j = 1:numStates
            destState = index2state(j,n);
            %compute P(i,j)
            probability = 1;
            for p = 1:n
                probability = probability*transitionProb(srcState(p),action(p),destState(p));
            end
            P(i,j) = probability; %ITS ACTUALLY STOCHASTIC
        end
    end
    
    shiftP = eye(numStates) - lambda*P;
    v = shiftP\rewards;
    
    %% Policy Improvement
    new_d = zeros(numStates,n);
    
    for i = 1:numStates
        myState = index2state(i,n);
        bestActionVal = -1000000;
        bestAction = 0;
        for j = 1:numActions
            action = actions(j,:);
            reward = compReward(myState,action,winProb,k);
            probVector = zeros(1,numStates);
            for s = 1:n
                destState = index2state(s,n);
                probVector(s) = 1;
                for p = 1:n
                    probVector(s) = probVector(s)*transitionProb(myState(p),action(p),destState(p));
                end
            end
            actionVal = reward+lambda*probVector*v;
            if actionVal > bestActionVal
                bestActionVal = actionVal;
                bestAction = j;
            end
        end
        new_d(i,:) = actions(bestAction,:);
    end
    
    %% Stopping condition
    err = norm(new_d-d);
    d = new_d;
    
end