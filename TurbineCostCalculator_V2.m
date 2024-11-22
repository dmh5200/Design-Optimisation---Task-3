function Turbine_Array_Cost = TurbineCostCalculator_V2(groups, radii)
    %X(:,1) = position of turbines in array
    %X(:,2) = height of turbines
    %X(:,3) = radiuses of turbines in array
    %X(:,4) = number of radi in each group

    %A = (X(:,4))';
    %R = X(:,3);
    %c1 = unique(A); % the unique values in the A (1,2,3,4,5)  
    %Radiuses = unique(R);
    %for i = 1:length(c1)
    %    Turbine_Groups(i,1) = sum(A==c1(i)); % number of times each unique value is repeated
    %end

    % Round group values to nearest integer
    groups = round(groups);

    % Round radii values to nearest m
    radii = round(radii);
 
    % Number of unique groups
    Turbine_Groups = unique(groups);
    % Number of turbines in each group
    Turbine_Group_Counts = histc(groups, Turbine_Groups);
    % Radiuses of turbines in each group
    Radiuses = zeros(length(Turbine_Groups), 1);
    for i = 1:length(Turbine_Groups)
        Radiuses(i) = radii(find(groups == Turbine_Groups(i), 1));
    end

    Turbine_Array_Cost = 0;
    for i = 1:length(Turbine_Groups)
        %Eq 3 from models doc
        Turbine_Array_Cost = Turbine_Array_Cost + (Turbine_Group_Counts(i)*((2/3) + ((1/3)*exp(-0.017*(Turbine_Group_Counts(i)^2))))*7.5*(Radiuses(i)^2.5));
    end

    % Multiply by 8 for total field cost
    %Turbine_Array_Cost = Turbine_Array_Cost * 8;
end