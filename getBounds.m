function [lb_orig, ub_orig] = getBounds()
% Define the lower and upper bounds for the variables
groups_min = 1; % Minimum group value
groups_max = 8; % Maximum group value
r_min = 30; % Minimum radius value
r_max = 50; % Maximum radius value
h_min = 90; % Minimum height value
h_max = 110; % Maximum height value
p_min = 0; % Minimum position value
p_max = 2000; % Maximum position value

lb_orig = [repmat(groups_min,1,8),repmat(r_min, 1, 8), repmat(h_min, 1, 8), repmat(p_min, 1, 8)]; % Lower bounds
ub_orig = [repmat(groups_max, 1, 8), repmat(r_max, 1, 8), repmat(h_max, 1, 8), repmat(p_max, 1, 8)]; % Upper bounds
