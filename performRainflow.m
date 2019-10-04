%% Perform Rainflow

% for loop to display the mean values of each gauge (combined values) and
% to graph each gauge's values against time.


% rf(1,:) cycles range (amplitude),
% rf(2,:) cycles mean,
% rf(3,:) cycles count,
% rf(4,:) cycles start (time),
% rf(5,:) cycles end (time),

%for SG1-6 (1000Hz)
f = waitbar(0, 'performing rainflow count');
for i = 1:6  
    
    str = ['Strain Gauge ', int2str(i)];
    mean_val = mean(fsg{i});
    min_val = min(fsg{i});
    max_val = max(fsg{i});
    dimm_val = 'MPa';
    fprintf('Gauge = %s, mean value = %.3f %s, min = %.3f %s, max = %.3f %s \n',str,mean_val, dimm_val, min_val, dimm_val, max_val, dimm_val);
    rf{i} = rainflow(fsg{i}  , t_1000hz); 
    waitbar(i/6,f);
end


%for SG7-16 (200Hz)
% for i = 7:16  
%     if i ~= 12
%         str = ['Strain Gauge ', int2str(i)];
%         mean_val = mean(fsg{i});
%         min_val = min(fsg{i});
%         max_val = max(fsg{i});
%         dimm_val = 'MPa';
%         fprintf('Gauge = %s, mean value = %.3f %s, min = %.3f %s, max = %.3f %s \n',str,mean_val, dimm_val, min_val, dimm_val, max_val, dimm_val);
%         rf{i} = rainflow(fsg{i} , t_200hz); 
%     end
%     waitbar((i-6)/6,f);
% end
close(f)
