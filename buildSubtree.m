function [inds, p, labels, bestFeatures, bestVals] = buildSubtree(X, Y, cols, inds, p,labels, bestFeatures, bestVals, node)
% Recursively splits nodes based on information gain

if isempty(inds{node})
    return;
end

curr_X = X(inds{node},:);
curr_Y = Y(inds{node});

% Stopsplitting the current node if Stopping criteria satisfied
if (stoppingCriteria(curr_X, curr_Y)==1)
  return;
end

%Otherwise, we need to split the current node on some feature
%Ypred(node)= 0;  % current node is not a leaf node;
% best_feature = 0; %best feature to split on
% best_val = 0; % best value to split the best feature on
% idxL = [];
% idxR = [];

[best_feature, best_val, ~] = findBestSplit(curr_X, curr_Y);  % you need to complete findBestplit.m

if (best_feature == 0)
  return;
end
% Split the current node into two nodes
idxL = curr_X(:, best_feature) < best_val;
idxR = ~idxL;


inds = [inds; inds{node}(idxL); inds{node}(idxR)];
inds{node} = [];   %clear out the current node
p = [p; node; node];
bestFeatures = [bestFeatures; best_feature; best_feature;];
bestVals = [bestVals; best_val; best_val;];
labels = [labels; sprintf('%s < %2.2f', cols{best_feature}, best_val); ...
    sprintf('%s >= %2.2f', cols{best_feature}, best_val)];
    


% Recurse on newly-create nodes
n = numel(p)-2;
[inds, p, labels, bestFeatures, bestVals] = buildSubtree(X, Y, cols, inds, p, labels, bestFeatures, bestVals, n+1);
[inds, p, labels, bestFeatures, bestVals] = buildSubtree(X, Y, cols, inds, p, labels, bestFeatures, bestVals, n+2);

end