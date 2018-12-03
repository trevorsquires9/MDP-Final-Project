%%%%%%%%%%%%%%%%%%%%%%%%%%%
% INDEX2STATE.m
%
% DESCRIPTION
%   Converts an index to appropriate state
%
% AUTHOR
%   Trevor Squires
%
% INPUT
%   index - index to be converted
%   n - length of output vector
% OUTPUT
%   state - corresponding state from index
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [state] = index2state(index,n)
state = zeros(1,n);
index = index-1;
while index ~= 0
    %find largest multiple of 3 less than index
    counter = 1;
    while index >= 3^counter
        counter = counter + 1;
    end
    counter = counter - 1;
    multiple = 3^counter;
    
    %find largest multiplier less than index
    if 2*multiple <= index
        state(n-counter) = 2;
    elseif multiple <= index
        state(n-counter) = 1;
    end
    index = index - state(n-counter)*multiple;

end

end