%% FilterStrainGauges

for i = 1:6      
    str = ['Strain Gauge ', int2str(i)];
    mean_val = mean(sg{1,i});
    min_val = min(sg{1,i});
    max_val = max(sg{1,i});
    dimm_val = 'um/m';
    fprintf('Gauge = %s, mean value = %.3f %s, range = %.3f %s,  max = %.3f, min = %.3f \n',str,mean_val, dimm_val, max_val - min_val, dimm_val, max_val, min_val);
end
    
fprintf('\n');

sg{1,1} = sg{1,1} - mean(sg{1,1}) -9;
sg{1,2} = sg{1,2} - mean(sg{1,2}) + 72.6;
sg{1,3} = sg{1,3} - mean(sg{1,3}) + 8;
sg{1,4} = sg{1,4} - mean(sg{1,4}) + 8;
sg{1,5} = sg{1,5} - mean(sg{1,5}) + 58.6;
sg{1,6} = sg{1,6} - mean(sg{1,6}) + 58.6;

load('LPFNum200Hz.mat');
load('LPFNum1000Hz.mat');

%create "filtered" sensor gauges
f = waitbar(0, 'filtering strain gauges');
for i = 1:6
    fsg{i} = conv(sg{i},Num1000Hz);
    fsg{i} = fsg{i}(1:length(sg{i}));
    waitbar(i/6,f);
end

for i = 7:16
    fsg{i} = conv(sg{i},Num200Hz);
    fsg{i} = fsg{i}(1:length(sg{i}));
    waitbar((i-6)/6,f);
end

fprintf('\n');
for i = 1:6      
    str = ['Strain Gauge ', int2str(i)];
    mean_val = mean(fsg{1,i});
%     min_val = min(fsg{1,i});
%     max_val = max(fsg{1,i});
    sg{1,i} = rmoutliers(fsg{1,i});
    mean_r = mean(sg{1,i});
    dimm_val = 'um/m';
%     fprintf('Gauge = %s, mean value = %.3f %s, mean of sg = %.3f, range = %.3f %s,  max = %.3f, min = %.3f \n',str,mean_val, dimm_val, mean_r, max_val - min_val, dimm_val, max_val, min_val);
    fprintf('Gauge = %s, real mean value = %.3f %s, outliers removed mean = %.3f%s\n' , str,mean_val, dimm_val, mean_r, dimm_val);
end

fprintf('\n');

% figure;
% plot(sg{1})
% 
% figure
% plot(fsg{1})


close(f)
% clear sg