function s = SN(n, fatigue_strength, knee_point, slope)
    if n >= knee_point
        s = fatigue_strength;
    else
        s = fatigue_strength .* (knee_point./n).^(1/slope);
    end
end