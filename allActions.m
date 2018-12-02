%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ALLACTIONS.m
%
% DESCRIPTION
%   Computes all possible ways that k can be broken into n ordered 
%   nonnegative integers
%
% AUTHOR
%   Trevor Squires
%
% ARGUMENTS
%   n - number of nonnegative integers
%   k - positive integer to be partitioned
%
% OUTPUT
%   partitions - all possible partitions of k into n ordered nonnegative
%   integers
%
% NOTES
%   Could be improved by providing an upper bound for efficient memory
%   usage
%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [actions] = allActions(n,k)

queue = zeros(1,n+1);
actions = [];
completed = zeros(1,(k+1)^n);
while ~isempty(queue)
    action = queue(1,:);
    queue(1,:) = [];
    value = (k+1)*ones(1,n);
    value = value.^(n-1:-1:0);
    value = value.*action(1:n);
    value = sum(value)+1;
    
    if completed(value) == 0
        completed(value) = 1;
        if action(n+1) == k
            actions = [actions; action(1:n)];
        else
            for i = 1:n
                tmp = action;
                tmp(i) = tmp(i) + 1;
                tmp(end) = tmp(n+1) + 1;
                queue(end+1,:) = tmp;
            end
        end
    end
end

