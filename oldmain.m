close all
clear all

[filename, pathname] = uigetfile({'*.dwh'},'Select record file');
Data_Path = [pathname, '\' , filename];
[channels, fileheader] = loadDWHv4(Data_Path);
fprintf('\n%s\n',filename);

% pause% 
% for i = 1:18
%    
%     [filename1, pathname1] = uigetfile({'*.dwh'},'Select record file');
%     Data_Path = [pathname1, '\' , filename1];
%     [channels1, fileheader1] = loadDWHv4(Data_Path);
%     fprintf('\n%s\n',filename1);    
%     
%     channels{1,1}.data = [channels{1,1}.data; channels1{1,1}.data];        
%     pause
%     
% end

for i = 1:length(channels)  
    
    str = channels{i}.Ch_Alias;
    mean_val = mean(channels{i}.data);
    dimm_val = channels{i}.Ch_Dimension;
    fprintf('Gauge = %s, mean value = %.3f %s\n',str,mean_val,dimm_val);
    figure
    plot( channels{i}.data);
    title(str);
    ylabel(dimm_val);
    
end