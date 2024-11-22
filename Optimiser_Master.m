%% Multiobjective genetic algorithm implementation

% Define inputs
% cost objective function inputs = [groups, radii]
% power objective function inputs = [radii, heights, positions]
% inputs = [groups, radii, heights, positions];

% Total number of variables
nVars = 32;

% Define the lower and upper bounds for the variables
[lb_orig, ub_orig] = getBounds();

% Define the normalized lower and upper bounds
lb_norm = zeros(1, nVars); % Lower bounds for normalized variables
ub_norm = ones(1, nVars); % Upper bounds for normalized variables

% Set up the options for gamultiobj
options = optimoptions('gamultiobj', ...
    'PopulationSize', 1000, ... % Increase population size
    'Generations', 100000, ... % Increase number of generations
    'UseParallel', true, ... % Enable parallel computing
    'Display', 'iter', ...
    'OutputFcn', @gaOutputFunction); % Set the output function

% Start parallel pool
parpool;

% Call gamultiobj
[z_norm, fval] = gamultiobj(@combinedFitnessFunction, nVars, [], [], [], [], lb_norm, ub_norm, @constraints4, options);

% Shut down parallel pool
delete(gcp('nocreate'));

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

% Plot results
plots(z_norm, fval, lb_orig, ub_orig);


function [state, options, optchanged] = gaOutputFunction(options, state, flag)
    persistent bestfvals;
    optchanged = false;

    switch flag
        case 'init'
            bestfvals = [];
        case 'iter'
            bestfvals = [bestfvals; min(state.Score)];
        case 'done'
            assignin('base', 'bestfvals', bestfvals);
    end
end