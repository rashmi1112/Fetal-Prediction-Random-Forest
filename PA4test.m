% AI in BME Class - Programming Assignment 4 - I
% Random Forest

%  ------------ Instructions --------------------------------------------------
% 
%  This file contains code that helps you get started. 
%  Complete the following .m files and test the functions in this exericse:
%
%     bagging.m
%     majorityVote.m
%   
%  You do not need to change any code in this file. 

%% Initialization
clear ; close all; clc
       
% ------------------ Part 1: Test your bagging.m -------------------------------
D = ones(1, 10);
for i = 2:11
  D = [D; i*ones(1,10)]
end

k=5;
bag = bagging(D, k);
display (bag);

fprintf('you should see a cell array with five 11x10 matrices bagged from D\n');
fprintf('Program paused. Press enter to continue.\n');
pause;

% -------------------- Part 2: Test your MajorityVote.m here -------------------

X=[-1 2 2 2 3 -1 2 2 3 0 2 1 2 3 2 2 2 1 2 2];
[finalVote, confidence] = majorityVote(X); 
 
fprintf('The majority vote for X is %.f with confidence of %.f%%\n', finalVote, confidence*100);
fprintf('The expectedmajority vote for X is 2 with a confidence of 60%%\n');

