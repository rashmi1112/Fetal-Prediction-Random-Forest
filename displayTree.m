function displayTree(t)
%% Display the tree
treeplot(t.p');
title('Decision tree');
[xs,ys,h,s] = treelayout(t.p');

for i = 2:numel(t.p)
	% Get my coordinate
	my_x = xs(i);
	my_y = ys(i);

	% Get parent coordinate
	parent_x = xs(t.p(i));
	parent_y = ys(t.p(i));

	% Calculate weight coordinate (midpoint)
	mid_x = (my_x + parent_x)/2;
	mid_y = (my_y + parent_y)/2;

    % Edge label
	text(mid_x,mid_y,t.labels{i-1});
    
    % Leaf label
    if ~isempty(t.inds{i})
        val = t.pred(i);
            text(my_x, my_y, sprintf('y=%.0f\n', val));
    end
end

end