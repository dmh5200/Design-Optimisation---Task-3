function Turbine_Array_Cost = TurbineCostCalulator(Turbine_Groups,Radiuses)
%Turbine_Array_Cost =  cost of the turbine array
%Turbine_Groups = array of turbine groups eg. [4,2,2]
%Radiuses = radius of each group eg [30,40,50]. Indexes must match between two inputs
    Turbine_Array_Cost = 0;
    for i = 1:length(Turbine_Groups)
        %Eq 3 from models doc
        Turbine_Array_Cost = Turbine_Array_Cost + (Turbine_Groups(i)*((2/3) + ((1/3)*exp(-0.017*(Turbine_Groups(i)^2))))*7.5*(Radiuses(i)^2.5));
    end
end