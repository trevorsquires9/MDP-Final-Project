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
    strState = dec2base(index-1,3);
    tmpState = num2str(strState)-'0';
    state = zeros(1,n);
    state(n-length(tmpState)+1:n) = tmpState;
end