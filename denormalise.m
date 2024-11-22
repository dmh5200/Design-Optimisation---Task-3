% Denormalise function
function z_denorm = denormalise(z, lb, ub)
    z_denorm = lb + z .* (ub - lb);
end 