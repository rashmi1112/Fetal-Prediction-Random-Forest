function [finalPrediction, confidence] = forestPredict(t, x)
% this function will return the majority prediction made by trees in t 
% and the confidence level of the prediction
% 
% t               - a structure array. each structure is a tree with five entries
% finalPrediction - return the final prediction for x made by t.
% confidence      - report the confidence of prediction 


% ------------------------- YOUR CODE HERE -------------------------------------

trees = size(t,2);

for i = 1:trees    % for every structure in array t, for  now, t = 2 = k
  for j = 1:size(x,1) % for every input in x
    predict(j,i) = treePredict(t(i),x(j,:));
  end
end
size_predict = size(predict)
for p = 1:size(predict,1)
  [finalPrediction(p,1) confidence(p,1)] = majorityVote(predict(p,:));
end


% ------------------------- YOUR CODE HERE -------------------------------------  
end
