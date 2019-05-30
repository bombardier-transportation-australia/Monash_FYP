%% Perform Rainflow

% for loop to display the mean values of each gauge (combined values) and
% to graph each gauge's values against time.

%for SG1-6 (1000Hz)
f = waitbar(0, 'performing rainflow count');
for i = 1:6  
    
    str = ['Strain Gauge ', int2str(i)];
    mean_val = mean(fsg{i});
    min_val = min(fsg{i});
    max_val = max(fsg{i});
    dimm_val = 'um/m';
    fprintf('Gauge = %s, mean value = %.3f %s, range = %.3f\n %s',str,mean_val, dimm_val, max_val - min_val, dimm_val);
    [fsgrf{i}.c,fsgrf{i}.hist,fsgrf{i}.edges,fsgrf{i}.rmm,fsgrf{i}.idx] = rainflow(fsg{i} , t_1000hz); 
    waitbar(i/6,f);
end

%for SG7-16 (200Hz)
for i = 7:16  
    if i ~= 12
        str = ['Strain Gauge ', int2str(i)];
        mean_val = mean(fsg{i});
        min_val = min(fsg{i});
        max_val = max(fsg{i});
        dimm_val = 'um/m';
        fprintf('Gauge = %s, mean value = %.3f %s, range = %.3f\n %s',str,mean_val, dimm_val, max_val - min_val, dimm_val);
        [fsgrf{i}.c,fsgrf{i}.hist,fsgrf{i}.edges,fsgrf{i}.rmm,fsgrf{i}.idx] = rainflow(fsg{i} , t_200hz); 
    end
    waitbar((i-6)/6,f);
end
close(f)