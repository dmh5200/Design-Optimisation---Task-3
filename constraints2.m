%% Constraints

% Constraint function to enforce grouping and other constraints
function [c, ceq] = constraints2(z)

    % Initialize inequality and equality constraints
    c = [];
    ceq = []; % This will remain empty since we cannot use equality constraints

    % Get bounds
    [lb_orig, ub_orig] = getBounds();

    % Denormalize the input vector z
    z_denorm = denormalize(z, lb_orig, ub_orig);

    % Split the input vector z into the required components
    groups = z_denorm(1:8); % Example: first 8 variables are groups
    radii = z_denorm(9:16); % Example: next 8 variables are radii
    heights = z_denorm(17:24); % Example: next 8 variables are heights
    positions = z_denorm(25:32); % Example: last 8 variables are positions

    % Grouping validity constraints
    validGroups = possible_Groups(); % Assuming this function is defined elsewhere
    isValidGroup = any(ismember(validGroups, groups, 'rows'));
    if ~isValidGroup
        ceq = [c, 1]; % Add a constraint violation if the group is not valid
    else
        ceq = [c, 0]; % Add an equality constraint if the group is valid
    end  

    % Ensure groups array values are integers
    if any(mod(groups, 1) ~= 0)
        ceq = [c, 1]; % Add a constraint violation if the group values are not integers
    else
        ceq = [c, 0]; % Add an equality constraint if the group values are integers
    end

    % Constrain resolution of radii to nearest cm
    %if any(mod(radii * 100, 1) ~= 0)
    %    c = [c, 1]; % Add a constraint violation if the radii are not to the nearest cm
    %else
    %    c = [c, 0]; % Add an equality constraint if the radii are to the nearest cm
    %end

    % Constrain resolution of heights to nearest cm
    %if any(mod(heights * 100, 1) ~= 0)
    %    c = [c, 1]; % Add a constraint violation if the heights are not to the nearest cm
    %else
    %    c = [c, 0]; % Add an equality constraint if the heights are to the nearest cm
    %end

    % Constrain resolution of positions to nearest cm
    %if any(mod(positions * 100, 1) ~= 0)
    %    c = [c, 1]; % Add a constraint violation if the positions are not to the nearest cm
    %else
    %    c = [c, 0]; % Add an equality constraint if the positions are to the nearest cm
    %end

    % Ensure that the position of each consecutive turbine is greater than the previous one
    %for i = 2:length(positions)
    %    if positions(i) <= positions(i-1) 
    %        c = [c, 1]; % Add a constraint violation if the positions are not in increasing order
    %    else
    %        c = [c, 0]; % Add an equality constraint if the positions are in increasing order
    %    end
    %end

    % Ensure that the gaps between turbines are at least 1m
    %for i = 2:length(positions)
    %    if positions(i) - positions(i-1) < 1
    %        c = [c, 1]; % Add a constraint violation if the gaps are less than 1m
    %    else
    %        c = [c, 0]; % Add an equality constraint if the gaps are at least 1m
    %    end
    %end

    % Grouping radii constraints
    uniqueGroups = unique(groups);
    for i = 1:length(uniqueGroups)
            groupIndices = find(groups == uniqueGroups(i));

                % Ensure all turbines in the same group have the same radius
                for j = 1:length(groupIndices)
                    c = [c, abs(radii(groupIndices(1)) - radii(groupIndices(j)))]; % radii(groupIndices(1)) <= radii(groupIndices(j))
                end
    end

    % Ensure c is always returned as a column vector
    if isempty(c)
        c = zeros(0, 1);
    end
end

% Denormalize function
function z_denorm = denormalize(z, lb, ub)
    z_denorm = lb + z .* (ub - lb);
end