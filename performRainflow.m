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
    dimm_val = 'um/m';
    fprintf('Gauge = %s, mean value = %.3f %s, range = %.3f\n %s',str,mean_val, dimm_val, max_val - min_val, dimm_val);
    rf{i} = rainflow(fsg{i} * 167000e-6 , t_1000hz); 
    waitbar(i/6,f);
end

%For SG7
str = ['Strain Gauge ', int2str(7)];
mean_val = mean(fsg{7});
min_val = min(fsg{7});
max_val = max(fsg{7});
dimm_val = 'um/m';
fprintf('Gauge = %s, mean value = %.3f %s, range = %.3f\n %s',str,mean_val, dimm_val, max_val - min_val, dimm_val);
rf{7} = rainflow(fsg{7}* 167000e-6 , t_200hz); 

%for SG8-16 (200Hz)
for i = 8:16  
    if i ~= 12
        str = ['Strain Gauge ', int2str(i)];
        mean_val = mean(fsg{i});
        min_val = min(fsg{i});
        max_val = max(fsg{i});
        dimm_val = 'um/m';
        fprintf('Gauge = %s, mean value = %.3f %s, range = %.3f\n %s',str,mean_val, dimm_val, max_val - min_val, dimm_val);
        rf{i} = rainflow(fsg{i} * 210000e-6, t_200hz); 
    end
    waitbar((i-6)/6,f);
end
close(f)
