%% Check output of Jensen wake model
% clc
clear all
close all

%Assign values to base parameters
Shape_Parameter = 2.2;
Scale_Parameter = 5;
Radius = 40;
Time_Frame = 8760;
Efficiency = 0.9;

Cut_In_Speed = 0.044*Radius + 0.778;
Rated_Speed = 0.133*Radius + 5.33;
Cut_Out_Speed = 0.222*Radius + 13.89;
Rated_Power = 0.243*(Radius^2.23);

%create vector of wind turbine positions, in meters
x = [0 400 700 1100 1400 1700 1900 2000];
%x = [0 285	571	857	1142 1428 1714 2000];
%create a vector of wind turbine heights, in meters
h = [100 110 100 110 110 110 110 110]; %note, the model takes into account the relative height, not the absolute (i.e. it doesn't model any ground effects)

%create a vector of wind turbine radii, in meters
R = [30 30 30 40 40 50 50 50];

%set the thrust coefficient of the turbines
%for this we will assume they are all constant
Ct = 0.75;

%set the wake expansion constant
%this determines how wide the wake spreads and how fast the wake recovers
kw = 0.06;

%the calcDef function calculates the velocity deficit at each turbine
%note: the first turbine will always have a deficit of 0, as it operates in undisturbed air
def = calcDef(x,h,R,Ct,kw);

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
    Cut_In_Speed = 0.044*R(i) + 0.778;
    Rated_Speed = 0.133*R(i) + 5.33;
    Cut_Out_Speed = 0.222*R(i) + 13.89;
    Rated_Power = 0.243*(R(i)^2.23);

    Turbine_Yearly_PowOut(i) = PowerAndWindIntegrator(Time_Frame,Efficiency,Cut_In_Speed,Cut_Out_Speed,Rated_Speed,Rated_Power,Shape_Parameter,Scale_Parameter,def(i));
end
plot(1:8,Turbine_Yearly_PowOut,'o')