clear
clc
close all;

lambda = 0.95;
epsilon = 1e-12;
Q = 4;
P = [0.1 0.3 0.3 0.3; 0 0.5 0.5 0; 0 0 0.8 0.2; 0.4 0 0 0.6];
moveCost = 300;

it = 0;
v_new = (-10000)*ones(1,Q^2);
err = 5;

%% Construct Value Function/Vector
while err > epsilon*(1-lambda)/2/lambda
    it = it+1;
    v_old = v_new;
    for i = 1:Q^2
        me = ceil(i/Q);
        trailer = i-(me-1)*Q; %thanks matlab
        
        for j = 1:Q
            if j == trailer
                reward = 0;
            else
                reward = -moveCost;
            end
            oldVec = v_old(Q*(j-1)+1:Q*j); %only 4 possible next states
            probVec = P(me,:);
            costVec = zeros(1,Q);
            for k = 1:Q
                costVec(k) = useCost(k,j);
            end
            reward = reward + dot(probVec,costVec);
            reward = reward + lambda*dot(oldVec,probVec);
            if reward > v_new(i)
                v_new(i) = reward;
            end
        end
    end
    err = norm(v_new-v_old,2);
    
end

%% Obtain Policy
v_star = v_new;
d_star = zeros(1,Q^2);

for i = 1:Q^2
    me = ceil(i/Q);
    trailer = i-(me-1)*Q;
    
    best = -100000;
    for j = 1:Q
        if j == trailer
            reward = 0;
        else
            reward = -moveCost;
        end
        
        oldVec = v_old(Q*(j-1)+1:Q*j); %only 4 possible next states
        probVec = P(me,:);
        costVec = zeros(1,Q);
        for k = 1:Q
            costVec(k) = useCost(k,j);
        end
        reward = reward + dot(probVec,costVec);
        reward = reward + lambda*dot(oldVec,probVec);
        if reward > best
            d_star(i) = j;
            best = reward;
        end
    end
end

d_star = reshape(d_star,Q,Q);
disp(d_star)







function [cost] = useCost(me,trailer)

if trailer == 1
    cost = 0;
elseif me == 1
    cost = -200;
elseif me == trailer
    cost = -50;
else
    cost = -100;
end
end
