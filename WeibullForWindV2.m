function Probability_Density = WeibullForWindV2(Shape_Parameter,Scale_Parameter,Wind_Speed) 
%Probability_Density =  probability density of the input wind speed to occour
%Shape Parameter, for weibull distribution
%Scale Parameter, for weibull distribution
%Wind_Speed = input wind speed to calculate probability distribution for
    %Eq 2 from models doc
    Probability_Density = (Shape_Parameter/Scale_Parameter)*((Wind_Speed/Scale_Parameter)^(Shape_Parameter-1))*exp(-(Wind_Speed/Scale_Parameter)^Shape_Parameter);

end