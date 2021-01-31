  function [finalVote, confidence] = majorityVote(input)
%
%This function performs majority voting for an input, i.e. counts the elements
% of a row vector and outputs the value with the most occurrences. 
% 
% input       - a row vector
% finalVote   - the value with the most occurrences in the input vector
% confidence  - report the confidence of prediction 
%            (= number of occurrences of the finalVote/number of elements in input)

%------------------- YOUR CODE HERE --------------------------------------------

% Take the unique elements from the input vector 
unique_elem = unique(input);

init =1;

% Count the maximum number of occurences in the given vector 
for i = unique_elem
  temp_vec = find(input==i);
  occ_vec(init,1) = size(temp_vec,2);
  init+=1;
end

% Calculate the index of max occurences of element in unique vector
[max_occ_val max_occ_val_idx] = max(occ_vec);

% Respective element of the input vector will give us the element with 
% maximum occurence
finalVote = input(1,max_occ_val_idx);
[max_val max_val_idx] = max(occ_vec);
confidence = max_val/size(input,2);

%-------------------------------------------------------------------------------
end