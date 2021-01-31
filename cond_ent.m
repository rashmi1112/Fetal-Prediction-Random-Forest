function result = cond_ent(Y, X)
% Calculates the conditional entropy of y given x

result = 0;

% ====================== YOUR CODE HERE ======================
classes = unique (X);
m = size(X,1);
prob =zeros(size(classes));
H = zeros(size(classes));

for i=1:size(classes),
  % Get probability
  prob(i) = size(find(X==classes(i)), 1)/m;
  % Get entropy for y values where x is the current value
  H(i) = ent(Y(X==classes(i))); 
end

% Get entropy
result = sum(prob .* H);
% =============================================================

end