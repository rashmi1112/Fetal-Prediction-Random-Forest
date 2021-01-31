function bag = bagging(D, k)

% This function creates new datasets (D1, D2, ..., Dk) from the input dataset D 
% by randomly selecting m samples with replacement. All new datasets should have
% the same dimension as the input dataset D.
% 
% D - input dataset matrix 
% k - number of new dataset to create
% bag  - return a kx1 cell array. each cell contains a new dataset matrix (Di)

% --------------- YOUR CODE HERE -----------------------------------------------
% you may find funtion randsample useful.  
% To use randsample in Octave, you will need to load the statistics package by
% including a line "pkg load statistics"

pkg load statistics

m = size(D,1); %1488x22

idx = 1:m;

for i = 1:k
  bag_idx{i,1} = randsample(idx,m,replacement=true);
end

size_bag_idx = size(bag_idx,1);

for j = 1:size_bag_idx
  bag{j,1} = D(bag_idx{j,1},:);
end

   
  

 
 
 
 
 
%-------------------------------------------------------------------------------
end