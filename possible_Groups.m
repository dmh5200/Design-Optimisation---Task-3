function [groupings] = possible_Groups()

function partitions = generatePartitions(set)
    if isempty(set)
        partitions = {{}};
        return;
    end
    
    first = set(1);
    rest = set(2:end);
    
    subpartitions = generatePartitions(rest);
    partitions = {};
    
    for i = 1:length(subpartitions)
        subpartition = subpartitions{i};
        for j = 1:length(subpartition) + 1
            newPartition = subpartition;
            if j > length(subpartition)
                newPartition{j} = [first];
            else
                newPartition{j} = [subpartition{j}, first];
            end
            partitions{end + 1} = newPartition;
        end
    end
end

% Number of turbines
numTurbines = 8;

% Generate all partitions of the set of turbines
turbineSet = 1:numTurbines;
partitions = generatePartitions(turbineSet);

% Convert partitions to groupings
groupings = [];
for i = 1:length(partitions)
    partition = partitions{i};
    group = zeros(1, numTurbines);
    for j = 1:length(partition)
        group(partition{j}) = j;
    end
    groupings = [groupings; group];
end

% Convert to table
%groupTable = array2table(groupings, 'VariableNames', arrayfun(@(x) ['Turbine' num2str(x)], 1:numTurbines, 'UniformOutput', false));

% Display the table
%disp(groupTable);

end