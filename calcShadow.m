function A0 = calcShadow(x,h,kw,Radii)
%calculates shadowing of the upstream turbine wake
%if the downstream turbine is in the wake, A0 = A = pi*R^2 0- i.e. the
%downstream rotor area
%if part of downstream tubine is not in the wake, A0 is equal to the
%portion of the downstream turbine within the wake. 

%x is the distance between the two turbines
%h is the height difference between the two turbine centrelines (hub)
%kw is the wake expansion factor
%R is the radius of the wind turbines

    if h - Radii(2) < -Radii(1) - kw*x && h + Radii(2) > Radii(1) + kw*x %check if wake is encapsulated by downstream turbine
        A0 = pi*Radii(1)^2;
        % disp('1 - wake encapsulated')

    elseif h - Radii(2) < -Radii(1) - kw*x || h + Radii(2) > Radii(1) + kw*x %check if one side of downstream turbine falls outside of wake 

        if  h + Radii(2) < -Radii(1) - kw*x || h - Radii(2) > Radii(1) + kw*x %check if entire downstream turbine falls outside of wake 
            A0 = 0;      
        else
            d = abs(h);
            r = Radii(2);
            R = Radii(1) + kw*x;
            A0 = (r^2)*acos( (d^2 + r^2 - R^2) / (2*d*r) ) + ...
                 (R^2)*acos( (d^2 + R^2 - r^2) / (2*d*R) ) - ...
                 0.5*sqrt( (-d + r + R)*(d + r - R)*(d - r + R)*(d + r + R));%portion of rotor within the wake
            % disp('2 - partial shadow')
        end
 
    else
        A0 = pi*Radii(2)^2; %all the downstream rotor is within the wake
        % disp('3 - full shadow')
    end

end