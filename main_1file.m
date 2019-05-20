close all
clear all

% PICK THE STARTING FILE FIRST
[filename, pathname] = uigetfile({'*.dwh'},'Select record file');
Data_Path = [pathname, '\' , filename];
[channels, fileheader] = loadDWHv4(Data_Path);
fprintf('\n%s',filename);

time_array = (1:length(channels{1,1}.data));
TT = zeros(1,length(channels));

% for loop to display the mean values of each gauge  and
% to graph each gauge's values against time.
fprintf('\n\n');
for i = 1:length(channels)  
    
    str = channels{i}.Ch_Alias;
    mean_val = mean(channels{i,1}.data);
    dimm_val = channels{i}.Ch_Dimension;
    fprintf('Gauge = %s, mean value = %.3f %s\n',str,mean_val,dimm_val);
    figure
    plot( channels{i,1}.data);
    title(str);
    ylabel(dimm_val);    
    [c,hist,edges,rmm,idx] = rainflow(channels{i,1}.data , time_array);    
%     TT(i) = array2table(c,'VariableNames',{'Count','Range','Mean','Start','End'});  
    TT = array2table(c,'VariableNames',{'Count','Range','Mean','Start','End'});  
end

% the final file in the sequence of dwh Files
% fprintf('\n\n');
% for i = 1:length(channels1)  
%     
%     str = channels1{i}.Ch_Alias;
%     mean_val = mean(channels1{i,1}.data);
%     dimm_val = channels1{i}.Ch_Dimension;
%     fprintf('Gauge = %s, mean value = %.3f %s\n',str,mean_val,dimm_val);
%     figure
%     plot( channels1{i,1}.data);
%     title(str);
%     ylabel(dimm_val);    
% end