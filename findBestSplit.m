function [best_feature, best_val, best_ig] = findBestSplit(X, Y)

%  ------------ Instructions --------------------------------------------------
% 
% Search for the best split within a randomly selected subset of features 
% You can modify your findBestSplit function created for PA3 

%initialization 
best_ig = -inf; %best information gain; 
best_feature = 0; %best feature to split on
best_val = 0; % best value to split on

% ====================== YOUR CODE HERE ========================================
% Loop over each feature in the subset of features

n = size(X,2);
s = round(sqrt(n));

idx = 1:n;

subset_features = randsample(idx,s,replacement=false);
H_Y = ent(Y);
for i = subset_features
  feat = X(:,i);
  vals = unique(feat);
  if(numel(vals) < 2)
    continue;
  end
  
  splits = [vals(1:end-1) + vals(2:end)]./2;
  
  for j = 1:size(splits,1)
    L_DATA = X(:,i)<=splits(j,1);
    idx_l = find(L_DATA==1);
    L_DATA = Y(idx_l,1);
    H_Y_L = ent(L_DATA);
    idx_r = find(L_DATA==0);
    R_DATA = Y(idx_r,1);
    H_Y_R = ent(R_DATA);
    H_Y_Xi = H_Y_L + H_Y_R;
    IG(j,1) = H_Y - H_Y_Xi;
  end
  
  [val ind] = max(IG);
  
   if(val>best_ig)
      best_ig = val;
      best_feature = i;
      best_val = splits(ind,1);
    end
end  
% ==============================================================================
end
