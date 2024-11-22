function Power_Out = TurbinePowerCalcV2(Wind_Speed,CIS,COS,RS,RP)
%Power_Out = power output of wind turbine at the input wind speed
%Wind_Speed = wind speed to calculate power output for
%CIS = cut in speed
%COS = cut in speed
%RS = Rated speed
%RP = Rated power
        %Eq 1 from models doc
        if (Wind_Speed<CIS)
            Power_Out = 0;
        elseif ((Wind_Speed>=CIS) && (Wind_Speed<RS))
            Power_Out = RP*((Wind_Speed/RS)^3);
        elseif ((Wind_Speed>=RS) && (Wind_Speed<COS))
            Power_Out = RP;
        else
            Power_Out = 0;
        end
end


      
