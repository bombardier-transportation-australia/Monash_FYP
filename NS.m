function n = NS(s, fatigue_strength, knee_point, slope)
    
% s

%     if s >= fatigue_strength
        n = knee_point ./ (s./fatigue_strength).^(slope);
%     else
%         
%         n = 1e16;
%     end
% n
end