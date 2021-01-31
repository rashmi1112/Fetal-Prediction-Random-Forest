function result = ent(Y)
% Calculates the entropy of a vector of values 

result = 0;

% ====================== YOUR CODE HERE ======================
classes = unique (Y);
m = size(Y,1);
prob =zeros(size(classes));

for i=1:size(classes),
  prob(i) = size(find(Y==classes(i)), 1)/m;
end

% Get entropy
result = -sum(prob .* log2(prob));
% =============================================================

end