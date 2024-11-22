function def = calcDef(x,h,R,Ct,kw)
%claculates the deficit at each turbine in the array based on their
%separation and height variations


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Depending on your parameterisation, your turbine positions may "cross
% over" - the following snippet of code sorts the turbines in increasing
% values of x (positions), such that the turbines are arranged from
% upstream to downstream

%sort turbine array in increasing values of x
[x,I] = sort(x);
%use index vector I to sort the height (h) and radius (R) vectors in the
%exact same way
h = h(I);
R = R(I);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if sum(diff([length(x) length(h) length(R)])) == 0
    dx = diff(x);
    dh = diff(h);
    TotalDef = zeros(size(dx));
    for i = 1:length(dx)
        SqDef = 0;
        for j = 1:i
            def = JensenWake(sum((dx(j:i))),sum((dh(j:i))),[R(j) R(i)],Ct,kw);
            SqDef = SqDef + def^2;
        end
        TotalDef(i) = sqrt(SqDef);
    end
    def = [0 TotalDef]; %add in deficit of 0 for first turbine in array

else
    error('Input vector lengths are not equal - check the x, h, and R vectors')
end