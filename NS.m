function n = NS(stress, s_kp, kpt, slope)
    
% stress = stress from rainflow counting = mean + amplitude
% s_kp = stress at knee point from sn curve
% kp = Value of N at knee point from sn curve
% slope = Value of slope from SN curve

% s

%% normal miners rule (intial)
%     if stress >= s_kp
%         n = kpt ./ (stress./s_kp).^(slope);
%     else
%         
%      n = 1e16;        
%     end
 

%% 2nd iteration with the equation in FKM guidelines
%      if stress >= s_kp
%         n = kpt .* (stress./s_kp).^(- slope);
%     else
%         
%      n = 1e16;        
%      end
 
%% 3rd iteration - elimentary miners rule
%      n = kpt .* (stress./s_kp).^(- slope);
 
%%  4th iteration - Miner rule according to Haibach

     if stress >= s_kp
     n = kpt * (stress./s_kp).^(- slope);   
    else
        
    n = kpt * (stress./s_kp).^(- 2*slope - 1);       
     end
     
end