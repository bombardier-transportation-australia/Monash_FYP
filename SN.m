function s = SN(n, fatigue_strength, knee_point, slope)
% function to create an S-N curve based on given input parameters

    if n >= knee_point
        s = fatigue_strength;
    else
        s = fatigue_strength .* (knee_point./n).^(1/slope);
    end
end