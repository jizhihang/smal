function [list] = cell2list(items, q) 

% q: qualifier

if nargin<2
    q = '';
end

list = ''; 
if isempty(items)
    return;
end

L       = length(items);
lst     = cell(L*2-1,1);
lst(1:2:end)    = items; 
lst(2:2:end-1)  = {[q ',' q]};

list    = [q lst{:} q];