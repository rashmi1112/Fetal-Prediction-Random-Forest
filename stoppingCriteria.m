function choice = stoppingCriteria(X, Y)
% Stop splitting the current node using the following criteria:
%   (1) the leaf is consistent (all samples in the node have the same Y value)
%   (2) if Y values are different but all samples in the leaf have the same X.

choice =0;

% ====================== YOUR CODE HERE ======================
% Check if the current leaf is consistent
if numel(unique(Y)) == 1
    choice =1;
    return;
end

% Check if all inputs have the same feature values(duplicated X rows, yet different Y)
% We do this by seeing if there are multiple unique rows of X
if size(unique(X,'rows'),1) == 1
    choice=1;
end

% =============================================================
end