% Draw selected wind turbine arrays (lower quartile, median, upper quartile of pareto front)

function draw_wind_turbine_array(z_norm, fval, lb_orig, ub_orig)
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

    % Sort the Pareto front solutions in ascending order of cost
    [costPareto, sortIdx] = sort(costPareto);
    powerPareto = powerPareto(sortIdx);
    radii = radii(sortIdx, :);
    heights = heights(sortIdx, :);
    positions = positions(sortIdx, :);

    % Determine the indices for the lower quartile, median, and upper quartile
    N = size(fval, 1);
    lowerQuartileIdx = round(quantile(1:N, 0.25));
    medianIdx = round(quantile(1:N, 0.50));
    upperQuartileIdx = round(quantile(1:N, 0.75));

    % Extract the rows corresponding to the quartiles
    radiiQuartiles = radii([lowerQuartileIdx, medianIdx, upperQuartileIdx], :);
    heightsQuartiles = heights([lowerQuartileIdx, medianIdx, upperQuartileIdx], :);
    positionsQuartiles = positions([lowerQuartileIdx, medianIdx, upperQuartileIdx], :);
    costQuartiles = costPareto([lowerQuartileIdx, medianIdx, upperQuartileIdx]);
    powerQuartiles = powerPareto([lowerQuartileIdx, medianIdx, upperQuartileIdx]);


    % Create a figure
    figure;

    % Loop through each quartile and create a subplot
    quartileLabels = {'Lower Quartile', 'Median', 'Upper Quartile'};
    colors = {'k', 'b', 'r'}; % Colors for different quartiles
    for q = 1:3
        subplot(3, 1, q); % Create a subplot for each quartile
        hold on;
        for i = 1:size(positionsQuartiles, 2)
            % Draw the tower (vertical line)
            plot([positionsQuartiles(q, i), positionsQuartiles(q, i)], [0, heightsQuartiles(q, i)], colors{q}, 'Color', [0 0 0 0.5], 'LineWidth', 2);
            
            % Draw the hub (horizontal line)
            plot([positionsQuartiles(q, i) - radiiQuartiles(q, i), positionsQuartiles(q, i) + radiiQuartiles(q, i)], [heightsQuartiles(q, i), heightsQuartiles(q, i)], colors{q}, 'Color', [0 0 1 0.5],  'LineWidth', 2);
            
            % Draw the rotor (vertical line) centered about the lowest x value of the hub
            rotorX = positionsQuartiles(q, i) - radiiQuartiles(q, i);
            plot([rotorX, rotorX], [heightsQuartiles(q, i) - radiiQuartiles(q, i), heightsQuartiles(q, i) + radiiQuartiles(q, i)], colors{q}, 'Color', [1 0 0 0.5],'LineWidth', 2);
        end
        % Set axis labels and title for each subplot
        xlabel('Position (m)', 'FontSize', 26);
        ylabel('Height (m)', 'FontSize', 26);
        title(['Wind Turbine Array Representation - ' quartileLabels{q}], "FontSize", 26);
        grid on;


        % Add labels for power output and cost
        text(0.9, 0.95, sprintf('Power Output: %.3g GWh', powerQuartiles(q)/1e6), 'Units', 'normalized', 'FontSize', 18, 'VerticalAlignment', 'top');
        text(0.9, 0.8, sprintf('Cost: £%.3g million', costQuartiles(q)/1e6), 'Units', 'normalized', 'FontSize', 18, 'VerticalAlignment', 'top');

        hold off;
    end

end

% Denormalize function
function z_denorm = denormalise(z, lb, ub)
    z_denorm = lb + z .* (ub - lb);
end