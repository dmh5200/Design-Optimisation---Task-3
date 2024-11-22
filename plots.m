function plots(z_norm, fval, lb_orig, ub_orig)

% Denormalise the Pareto front solutions
z_denorm = denormalise(z_norm, lb_orig, ub_orig);

% Round group values to nearest integer
groups = round(z_denorm(:, 1:8));

% Round radii values to nearest m
radii = round(z_denorm(:, 9:16));

% Round heights values to nearest m
heights = round(z_denorm(:, 17:24));

% Round positions values to nearest m
positions = round(z_denorm(:, 25:32));

% Extract the Pareto front solutions
costPareto = fval(:, 1); % Cost values
powerPareto = -fval(:, 2); % Power values (negate to get positive values)

% Display the results
disp('Pareto front solutions for cost:');
disp(costPareto);
disp('Pareto front solutions for power:');
disp(powerPareto);

% Sort the Pareto front solutions in ascending order of cost
[costPareto_sort, sortIdx] = sort(costPareto);
powerPareto_sort = powerPareto(sortIdx);

% Plot the Pareto front with a smooth line
figure;
plot(costPareto_sort/1e6, powerPareto_sort/1e6, '-o', 'LineWidth', 1, 'MarkerSize', 6);
xlabel('Cost (million £)', 'FontSize', 26);
ylabel('Annual Energy Production (GWh)', 'FontSize', 26);
legend('Pareto Front', 'Location', 'best', 'FontSize', 20);
grid on;

% set axes tick label size
% get axes handle
ax = gca;
set(gca, 'FontSize', 22);

% Plot the convergence plot
bestfvals = evalin('base', 'bestfvals');
generations = 1:size(bestfvals, 1);
bestCost = bestfvals(:, 1); % Best cost values over generations
bestPower = -bestfvals(:, 2); % Best power values over generations (negate to get positive values)

figure;
plot(generations, bestCost, '-o', 'LineWidth', 1, 'MarkerSize', 6);
hold on;
plot(generations, bestPower, '-o', 'LineWidth', 1, 'MarkerSize', 6);
xlabel('Generation', 'FontSize', 26);
ylabel('Objective Value', 'FontSize', 26);
legend('Best Cost', 'Best Annual Energy Production', 'Location', 'best');
grid on;
hold off;

ax = gca;
set(gca, 'FontSize', 22);

% Scatter plot of groups against cost with colour representing power
% Find the unique elements in each row of the groups matrix
numUniqueGroups = zeros(size(groups, 1), 1);
for i = 1:size(groups, 1)
    numUniqueGroups(i) = numel(unique(groups(i, :)));
end
figure;
scatter(numUniqueGroups(:), costPareto(:), 50, powerPareto(:), 'filled');
xlabel('Unique Groups', 'FontSize', 26);
ylabel('Cost (million £)', 'FontSize', 26);
cb = colorbar;
cb.Label.String = 'Annual Energy Production (GWh)';
grid on;
xlim([0, 8]);

ax = gca;
set(gca, 'FontSize', 22);


power_scatter = repmat(powerPareto, 1, 8);
cost_scatter = repmat(costPareto, 1, 8);


% Create a figure for the subplots
figure;

% Generate a colormap with the same number of colors as there are Pareto front points
numPoints = size(radii, 1);
colors = parula(numPoints); % Use the 'parula' colormap for a continuous gradient

% Normalize powerPareto to the range [1, numPoints] to map to colormap indices
[~, ~, colorIndices] = histcounts(powerPareto, numPoints);

% Subplot 1: Scatter plot of radii against power with color representing different points on the Pareto curve
subplot(1, 2, 1);
hold on;
for i = 1:size(radii, 1)
    scatter(radii(i, :), power_scatter(i, :), 50, colors(colorIndices(i), :), 'filled');
end
xlabel('Radii (m)', 'FontSize', 26);
ylabel('Annual Energy Production (GWh)', 'FontSize', 26);
colormap(colors);
grid on;
hold off;

ax = gca;
set(gca, 'FontSize', 22);

% Subplot 2: Scatter plot of radii against cost with color representing different points on the Pareto curve
% Normalize powerPareto to the range [1, numPoints] to map to colormap indices
[~, ~, colorIndices] = histcounts(costPareto, numPoints);

subplot(1, 2, 2);
hold on;
for i = 1:size(radii, 1)
    scatter(radii(i, :), cost_scatter(i, :), 50, colors(colorIndices(i), :), 'filled');
end
xlabel('Radii (m)', 'FontSize', 26);
ylabel('Cost (million £)', 'FontSize', 26);
colormap(colors);
grid on;
hold off;

ax = gca;
set(gca, 'FontSize', 22);

% Create a figure for the subplots
figure;

% Generate a colormap with the same number of colors as there are Pareto front points
numPoints = size(heights, 1);
colors = parula(numPoints); % Use the 'parula' colormap for a continuous gradient

% Normalize powerPareto to the range [1, numPoints] to map to colormap indices
[~, ~, colorIndices] = histcounts(powerPareto, numPoints);

% Subplot 1: Scatter plot of heights against power with color representing different points on the Pareto curve
subplot(1, 2, 1);
hold on;
for i = 1:size(heights, 1)
    scatter(heights(i, :), power_scatter(i, :), 50, colors(colorIndices(i), :), 'filled');
end
xlabel('Heights (m)', 'FontSize', 26);
ylabel('Annual Energy Production (GWh)', 'FontSize', 26);
colormap(colors);
grid on;
hold off;

ax = gca;
set(gca, 'FontSize', 22);

% Subplot 2: Scatter plot of heights against cost with color representing different points on the Pareto curve
% Normalize powerPareto to the range [1, numPoints] to map to colormap indices
[~, ~, colorIndices] = histcounts(costPareto, numPoints);

subplot(1, 2, 2);
hold on;
for i = 1:size(heights, 1)
    scatter(heights(i, :), cost_scatter(i, :), 50, colors(colorIndices(i), :), 'filled');
end
xlabel('Heights (m)', 'FontSize', 26);
ylabel('Cost (million £)',  'FontSize', 26);
colormap(colors);
grid on;
hold off;

ax = gca;
set(gca, 'FontSize', 22);

% Create a figure for the subplots
figure;

% Generate a colormap with the same number of colors as there are Pareto front points
numPoints = size(positions, 1);
colors = parula(numPoints); % Use the 'parula' colormap for a continuous gradient

% Normalize powerPareto to the range [1, numPoints] to map to colormap indices
[~, ~, colorIndices] = histcounts(powerPareto, numPoints);

% Subplot 1: Scatter plot of positions against power with color representing different points on the Pareto curve
subplot(1, 2, 1);
hold on;
for i = 1:size(positions, 1)
    scatter(positions(i, :), power_scatter(i, :), 50, colors(colorIndices(i), :), 'filled');
end
xlabel('Positions (m)', 'FontSize', 26);
ylabel('Annual Energy Production (GWh)', 'FontSize', 26);
colormap(colors);
grid on;
hold off;

ax = gca;
set(gca, 'FontSize', 22);

% Subplot 2: Scatter plot of positions against cost with color representing different points on the Pareto curve
% Normalize powerPareto to the range [1, numPoints] to map to colormap indices
[~, ~, colorIndices] = histcounts(costPareto, numPoints);

subplot(1, 2, 2);
hold on;
for i = 1:size(positions, 1)
    scatter(positions(i, :), cost_scatter(i, :), 50, colors(colorIndices(i), :), 'filled');
end
xlabel('Positions (m)', 'FontSize', 26);
ylabel('Cost (million £)', 'FontSize', 26);
colormap(colors);
grid on;
hold off;

ax = gca;
set(gca, 'FontSize', 22);



end