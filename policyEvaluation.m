clear
clc
close all;

%% Set up variables
states = 5;
lambda = 0.95;

Pstay = [1 0 0 0 0; 0 0.3 0.4 0.2 0.1; 0 0.2 0.3 0.5 0; 0 0.1 0 0.8 0.1; 0 0.4 0 0 0.6];
Pgo = zeros(states); Pgo(:,1) = ones(states,1);
R = 53;


%% Choose initial policy
d = zeros(1,states); %0 is stay, 1 is leave

%% Compute rewards of policy
rewards = zeros(states,1);
rewards(1) = 0;
for i = 2:states
    if d(i) == 0
        rewards(i) = i-1;
    else
        rewards(i) = R;
    end
end

%% Policy Evaluation
P = zeros(states);
for i = 1:states %construct P
    if d(i) == 0
        P(i,:) = Pstay(i,:);
    else
        P(i,:) = Pgo(i,:);
    end
end
shiftP = eye(states) - lambda*P;
v = shiftP\rewards; %solve for value function

%% Policy Improvement
d(1) = 1;
for i = 2:states
    if v(i) > R
        d(i) = 0;
    elseif v(i) < R
        d(i) = 1;
    end
end
