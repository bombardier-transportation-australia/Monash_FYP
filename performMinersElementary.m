%% PerformMinersElementary

% rf(1,:) cycles range (amplitude),
% rf(2,:) cycles mean,
% rf(3,:) cycles count,
% rf(4,:) cycles start (time),
% rf(5,:) cycles end (time),

% currently the code is only using stress amplitude = s. 
%This would be correct if mean stress is = 0. This is not the case for our project.
%To add mean stress: s =rf{i}(1,:) + rf{i}(2,:); (amplitude + mean)

f = waitbar(0, 'Performing Miners Elementary Rule');
damages = zeros(length(rf),1);
for i= 1 : length(rf)
    if i ~= 12 
        %Original code
%        s = rf{i}(1,:);   

       % modified code
       s = rf{i}(:,1) + rf{i}(:,2);
       n = rf{i}(:,3);
       if i >= 1 && i <= 6
           N = NS(s,126.5,1e6,5);
       end
       
%        if i == 7
%            N = NS(s,152.9,1e6,5);
%        end
%        if i >= 8 && i <= 10 || i == 13
%            N = NS(s,52.6,5e6,3);
%        end
%        if i >= 15 && i <= 16 || i == 11
%            N = NS(s,46.2,5e6,3);
%        end
%        if i == 14
%            N = NS(s,41.5,5e6,6);
%        end
       fraction = n ./ N;
       
       damages(i) = sum(fraction);
    end
   waitbar(i/length(rf),f);
end

fprintf('\nDAMAGES\n');

for i = 1:6
        str = ['Strain Gauge ', int2str(i)];
        fprintf('Gauge = %s, damage = %1.10e \n',str, damages(i));
end


close(f);