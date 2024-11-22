function def = JensenWake(x,h,R,Ct,kw)

    %calcualtes the velocity deficit induced from an upstream turbine
    %x is distance between turbines
    %h is height difference between turbine hubs
    %Ct is coefficient of thrust
    %kw is the wake expansion factor
    %R is rotor radius (the same across the linear wind turbine farm)

    %calculate partial shadow effect (if any)
    A0 = calcShadow(x,h,kw,R);

    %cacluate deficit
    def = ((1 - sqrt(1-Ct))./((1 + kw*x/R(1)).^2))*(A0/(pi*R(2)^2)); %if no partial shadowing, R0/R = 1;

end