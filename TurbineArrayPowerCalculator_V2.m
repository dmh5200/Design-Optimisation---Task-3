function Array_Yearly_Pow = TurbineArrayPowerCalculator_V2(radii, heights, positions)
    %X(:,1) = position of turbines in array
    %X(:,2) = height of turbines
    %X(:,3) = radiuses of turbines in array
    %X(:,4) = number of radi in each group

    d = positions;
    h = heights;
    r = radii;

    % Round radii values to nearest m
    r = round(r);
    % Round heights values to nearest m
    h = round(h);
    % Round positions values to nearest m
    d = round(d);
    
    %Assign values to base parameters
    Shape_Parameter = 2.2;
    Scale_Parameter = 5;
    Time_Frame = 8760;
    Efficiency = 0.9;
    %set the thrust coefficient of the turbines
    %for this we will assume they are all constant
    Ct = 0.75;
    
    %set the wake expansion constant
    %this determines how wide the wake spreads and how fast the wake recovers
    kw = 0.06;
    
    %the calcDef function calculates the velocity deficit at each turbine
    %note: the first turbine will always have a deficit of 0, as it operates in undisturbed air
    def = calcDef(d,h,r,Ct,kw);
    
    %we can now calculate the velocity at all turbines - where v is the
    %incoming wind speed
    %v = 10; %10 m/s undisturbed, upstream wind speed
    %vel = v*(1-def); %velocities at each turbine
    
    %have a play with the incoming velocity, spacings, heights, radii, and number of turbines to
    %get a feel for how the velocity at each turbine changes.
    %note - to change the number of turbines, you have to make sure the length
    %of each vector - x, h, R - are the same
    %In the example here, the length is 3, so there are 3 turbines.
    
    %from here you can calculate the power output of your turbine array at any
    %incoming wind speed! Notice how you only have to calculate your deficits
    %ONCE - they are independent of incoming speed - you can then iterate
    %through different incoming velocities to calculate the velocity at each
    %turbine in the array. From there you can calculate how much power each
    %turbine produces for a given wind speed.
    Turbine_Yearly_PowOut = zeros(1,8);
    for i = 1:8
        Cut_In_Speed = 0.044*r(i) + 0.778;
        Rated_Speed = 0.133*r(i) + 5.33;
        Cut_Out_Speed = 0.222*r(i) + 13.89;
        Rated_Power = 0.243*(r(i)^2.23);
    
        Turbine_Yearly_PowOut(i) = PowerAndWindIntegrator(Time_Frame,Efficiency,Cut_In_Speed,Cut_Out_Speed,Rated_Speed,Rated_Power,Shape_Parameter,Scale_Parameter,def(i));
    end
    Array_Yearly_Pow = sum(Turbine_Yearly_PowOut);

    % Multiply by 8 for total field power
    %Array_Yearly_Pow = Array_Yearly_Pow * 8;
end