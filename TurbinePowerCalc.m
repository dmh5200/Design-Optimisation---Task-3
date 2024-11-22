function [Power_Outs,Cut_In_Speed,Cut_Out_Speed] = TurbinePowerCalc(Wind_Speeds, Radius)


    for  i = 1:length(Wind_Speeds)
        if (Wind_Speeds(i)<Cut_In_Speed)
            Power_Outs(i) = 0;
        elseif ((Wind_Speeds(i)>=Cut_In_Speed) && (Wind_Speeds(i)<Rated_Speed))
            Power_Outs(i) = Rated_Power*((Wind_Speeds(i)/Rated_Speed)^3);
        elseif ((Wind_Speeds(i)>=Rated_Speed) && (Wind_Speeds(i)<Cut_Out_Speed))
            Power_Outs(i) = Rated_Power;
        else
            Power_Outs(i) = 0;
        end
    end
end

      
