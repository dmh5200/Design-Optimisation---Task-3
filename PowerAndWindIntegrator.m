function Power_Over_TimeFrame = PowerAndWindIntegrator(TimeFrame,Efficiency,CIS,COS,RS,RP,ShP,ScP,Deficiency)
%Power_Over_TimeFrame =  total power produced by wind turbine over a given time frame
%TimeFrame = number of hours to calculate power oputput over
%Efficiency = Efficiency of wind turbine
%CIS = cut in speed of wind turbine
%COS = cut out speed of wind turbine
%RS = rated speed of wind turbine
%RP = rated power of wind turbine
%ShP = shape parameter of weibull distribution
%ScP = scake parameter of weibull distribution
%Defficiency = wind deficiency seen by the turbine when in an array, def is 0 when there is no deficiency
    
    %initialise variables etc
    Int_Vec = round(CIS,1):0.1:round(COS,1); %this sets up a vector wind speeds between CIS and COS at a resolution of 0.1
    Int_Vec = [Int_Vec(1)-0.1, Int_Vec];
    Num_Int_Points = length(Int_Vec);
    Pwr_Out = zeros(1,Num_Int_Points);
    Prob_Dens = zeros(1,Num_Int_Points);
    PowAndWind_Integral = 0;
    
    %perform integration by parts on the combination of turbine power and weidbull distribution
    for i = 2:Num_Int_Points
        %calculate the actual wind speed seen by the turbine due to defecit
        WS_Seen_By_Turbine = Int_Vec(i)*(1-Deficiency);
        %calculate turbine power output
        Pwr_Out(i) = TurbinePowerCalcV2(WS_Seen_By_Turbine,CIS,COS,RS,RP);
        %calculate the probably density at the wind speed
        Prob_Dens(i) = WeibullForWindV2(ShP,ScP,Int_Vec(i));
        %Add to rolling sum
        PowAndWind_Integral = PowAndWind_Integral + (Pwr_Out(i) * Prob_Dens(i) * (Int_Vec(i) - Int_Vec(i-1)));
    end
    %Eq 4 from models doc
    Power_Over_TimeFrame = Efficiency * TimeFrame * PowAndWind_Integral;
end