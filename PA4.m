% AI in BME Class - Programming Assignment 4 - II
% Random Forest

%  ------------ Instructions --------------------------------------------------
% 
%  This file contains code that helps you get started. 
%  You will need to complete the excercise in PA4test.m first.
%  Complete and test the following functions in this exericse:
%
%   forestPredict.m
%
%
% Initialization
clear ; close all; clc
pkg load statistics;    % remove if you are using MATLAB

%% Load the data
M = load('PA4data.txt');
[m,n] = size(M);
Per = 0.7;    % 70% data used for training
randomidx = randperm(m);
M_training = M(randomidx(1:round(Per*m)),:);

M_testing = M(randomidx(round(Per*m)+1:end),:);

% We want to predict the last column NSP (Normal=1; Suspect=2; Pathologic=3)...
Y = M_training(:,end);
% ...based on the other features (all but the last column)
X = M_training(:,1:end-1);


% feature names
cols = {'LB', 'AC', 'FM', 'UC', 'DL','DS', 'DP','ASTV','MSTV', 'ALTV',...
    'MLTV', 'Width', 'Min', 'Max', 'Nmax', 'Nzeros', 'Mode', 'Mean', ...
    'Median', 'Variance', 'Tendency'};
    
%% ========== Build the Random Forest ==========================================
% You will build a random forest to predict Y. 
% Training dataset will be used to create k datasets (D1, D2, ..., Dk) using 
% bagging (random sampling with replacement)
% Each dataset will be used to train a decison tree, which is grown by 
% recursively splitting each node until the leaf is consistent or all inputs 
% have the same feature values.
% 
% X is an mxn matrix, where m is the number of points and n is the
% number of features.
% Y is an mx1 vector of classes 
%
% t is a structure array. Each structure has five entries
% t.p is a vector with the index of each node's parent node
% t.inds is the rows of X in each node (non-empty only for leaves)
% t.bestFeatures is a vector with the feature used to split at each decision node 
% t.bestVals is a vector with the feature value used to split at each decision node 
% t.pred is a vector with y prediction at each leaf node and 0 for decision nodes

% ------------ Part 1: Bagging-------------------------------------------------
% create dataset D(i) by randomly selecting m samples with replacement
D = M_training;
k = 10;              % you can set the k value here
bag = bagging(D, k);

%-------------- Part 2: traing k decision trees with modification ----------------
for i=1:k

  Xi = bag{i}(:, 1:end-1);
  Yi = bag{i}(:, end);

inds = {1:size(Xi,1)}; % A cell per node containing indices of all data in that node
p = 0; % Vector contiaining the index of the parent node for each node
labels = {}; % A label for each node
bestFeatures = 0; % best feature split on of the parent node for each node
bestVals = 0; % best value split on of the parent node for each node

% Create tree by splitting on the root
[inds, p, labels, bestFeatures, bestVals] = buildSubtree(Xi, Yi, cols,inds, p, labels, bestFeatures, bestVals,1);
Ypred = zeros(length(p),1); %

for j = 1:size(p)
  if ~isempty(inds{j})
    if numel(unique(Yi(inds{j}))) == 1
      Ypred(j)= unique(Yi(inds{j}));
    elseif size(unique(Xi(inds{j}),'rows'),1) == 1
      Ypred(j)= -1; % inconsistent data
    end
  end
end

t(i).inds = inds;
t(i).p = p;
t(i).bestFeatures = bestFeatures;
t(i).bestVals = bestVals;
t(i).pred = Ypred;
t(i).labels = labels;
printf("Tree built for k = %d\n",i);
end 
%% ---------------- Part 3: Accuracy on Training and Testing Data sets --------   
%=======================YOUR CODE HERE========================================

% -- Compute accuracy on our training set---------------
[finalVote confidence] = forestPredict(t, M_training);
correctTrain = mean(double(finalVote==Y)*100); %you need to change this
fprintf('Train Accuracy: %.2f %%\n', correctTrain);
fprintf('Expected training accuracy: above 95%%\n');

% -- Compute accuracy on our testing set ---------------
Ytest = M_testing(:,end);
Xtest = M_testing(:,1:end-1);
[finalVote confidence] = forestPredict(t,Xtest);
correctTest = mean(double(finalVote==Ytest)*100); %you need to change this
fprintf('Testing set prediction Accuracy: %.2f%%\n', correctTest);
fprintf('Expected accuracy: above 88%%\n');