
% Combined fitness function
function f = combinedFitnessFunction(z)

    % Define the lower and upper bounds for the variables
    [lb_orig, ub_orig] = getBounds();

    % Denormalise the input vector z
    z_denorm = denormalise(z, lb_orig, ub_orig);

    % Split the input vector z into the required components
    groups = z_denorm(1:8); % Example: first 2 variables are groups
    radii = z_denorm(9:16); % Example: next 2 variables are radii
    heights = z_denorm(17:24); % Example: next 2 variables are heights
    positions = z_denorm(25:32); % Example: last 2 variables are positions
    
    % Evaluate the objective functions
    cost = TurbineCostCalculator_V2(groups, radii);
    power = -TurbineArrayPowerCalculator_V2(radii, heights, positions); % Negative sign to maximise power
    
    % Combine the objectives into a single vector
    f = [cost, power];
end