


clear


%% block1
%Let user select root folder

%TODO: ADD ABILITY TO HAVE MULTIPLE ROOT FOLDERS SO THAT A WEEK'S WORTH OF
%DATA CAN BE SELECTED
folder = uigetdir('.');
%Make a table with all the .dwh files contained within the root folder,
%including subfolders
files = struct2table(dir([folder,'\**\*.dwh']));

%initialise record file length variables
length_1hz = 0;
length_200hz = 0;
length_1000hz = 0;
length_2000hz = 0;
f = waitbar(0, 'loading headers');
for i=1:height(files)
    path  = [files.folder{i} , '\', files.name{i}];
    %load the header of each file
    [~,fileheader] = loadDWHv4(path,1);
    %store the timestamp for each file in MATLAB datenum format in the
    %files table
    datestring = strtrim([fileheader.Date, ' ', fileheader.Time]);
    files.datenum(i) = datenum(datetime(datestring,'InputFormat','yy.MM.dd HH:mm:ss'));
    %accumulate total length of each type of file
    if fileheader.ftast == 1
        length_1hz = length_1hz + fileheader.SamplesPerCh;
    end
    if fileheader.ftast == 200
        length_200hz = length_200hz + fileheader.SamplesPerCh;
    end
    %for 1000Hz files
    if fileheader.ftast == 1000 && fileheader.AzCh == 6
        length_1000hz = length_1000hz + fileheader.SamplesPerCh;
    end
    if fileheader.ftast == 1000 && fileheader.AzCh == 3
        length_2000hz = length_2000hz + fileheader.SamplesPerCh;
    end
    waitbar(i/height(files),f);
end
close(f);
%approximate total lengths. A padding of 10% is added because samplesPerCh
%is innacurate
length_1hz = ceil(length_1hz * 1.001);
length_200hz = ceil(length_200hz * 1.001);
length_2000hz = ceil(length_2000hz * 1.001);
length_1000hz = ceil(length_1000hz * 1.001);
clear datestring i fileheader
%sort files by timestamp
files = sortrows(files, 'datenum'); 

%%
%initialise all variables
t_1hz = zeros(length_1hz, 0);
gps_date = zeros(length_1hz, 0);
gps_time = zeros(length_1hz, 0);
gps_latitude = zeros(length_1hz, 0);
gps_longitude = zeros(length_1hz, 0);
gps_speed = zeros(length_1hz, 0);


t_200hz = zeros(length_200hz, 0);
%primary suspension sensors
for i = 1:3
    ps{i} = zeros(length_200hz, 0);
end
%secondary suspension sensors
for i = 1:6
    ss{i} = zeros(length_200hz, 0);
end
%Sensor gauges
for i = 7:16
    sg{i}  = zeros(length_200hz, 0);
end

t_1000hz = zeros(length_1000hz, 0);
speed  = zeros(length_1000hz, 0);
acc4  = zeros(length_1000hz, 0);
%bogie strain gauges
for i = 1:6
    sg{i}  = zeros(length_1000hz, 0);
end


t_2000hz = zeros(length_2000hz, 0);
%accelerometers on axle 1 MB1
acc1  = zeros(length_2000hz, 0);
acc2  = zeros(length_2000hz, 0);
acc3  = zeros(length_2000hz, 0);


% % for loop to add every dwh file after the first one into a combined answer
% % which fits into channels.data

position_1hz = 1;
position_200hz = 1;
position_1000hz = 1;
position_2000hz = 1;
f = waitbar(0, 'loading files');
for i = 1: height(files)

    path  = [files.folder{i} , '\', files.name{i}];

    [channels, fileheader] = loadDWHv4(path);  
    if fileheader.ftast == 1
        record_length = length(channels{1}.data);
        t_1hz(position_1hz:position_1hz + record_length - 1) = fileheader.t';
        gps_date(position_1hz:position_1hz + record_length - 1) = channels{1}.data;
        gps_time(position_1hz:position_1hz + record_length - 1) = channels{2}.data;
        gps_latitude(position_1hz:position_1hz + record_length - 1) = channels{3}.data;
        gps_longitude(position_1hz:position_1hz + record_length - 1) = channels{4}.data;
        gps_speed(position_1hz:position_1hz + record_length - 1) = channels{5}.data;

        position_1hz = position_1hz + record_length;
    end
    if fileheader.ftast == 200
        record_length = length(channels{1}.data);
        t_200hz(position_200hz:position_200hz + record_length - 1) = fileheader.t';
        %Primary Suspension Proximity Sensors
        for  j = 1 : 4
            ps{j}(position_200hz:position_200hz + record_length -1) = channels{j}.data;
        end
        for j = 1 : 6
            ss{j}(position_200hz:position_200hz + record_length -1) = channels{j + 5}.data;
        end
        for j = 7 :16
            sg{j}(position_200hz:position_200hz + record_length -1) = channels{j + 7}.data;
        end
        acc4(position_200hz:position_200hz + record_length -1) = channels{11}.data;
        speed(position_200hz:position_200hz + record_length -1) = channels{12}.data;
        
        

        position_200hz = position_200hz + record_length;
    end
    %for 1000Hz files
    if fileheader.ftast == 1000 && fileheader.AzCh == 6
        record_length = length(channels{1}.data);

        t_1000hz(position_1000hz:position_1000hz + record_length - 1) = fileheader.t';
        %Sensor gauges (bogies)
        for j = 1:6
            sg{j}(position_1000hz:position_1000hz + record_length -1) = channels{j}.data;
        end
                
        position_1000hz = position_1000hz + record_length;
    end
    %for 2000Hz files
    if fileheader.ftast == 1000 && fileheader.AzCh == 3
        record_length = length(channels{1}.data);
        t_2000hz(position_2000hz:position_2000hz + record_length - 1) = fileheader.t';
        acc1(position_2000hz:position_2000hz + record_length -1) = channels{1}.data;
        acc2(position_2000hz:position_2000hz + record_length -1) = channels{2}.data;
        acc3(position_2000hz:position_2000hz + record_length -1) = channels{3}.data;


        
        position_2000hz = position_2000hz + record_length;
    end
    waitbar(i/height(files),f);
end
close(f);
%%
load('LPFNum200Hz.mat');
load('LPFNum1000Hz.mat');

%create "filtered" sensor gauges
for i = 1:6
    fsg{i} = conv(sg{i},Num1000Hz);
    fsg{i} = fsg{i}(1:length(sg{i}));
end

for i = 7:16
    fsg{i} = conv(sg{i},Num200Hz);
    fsg{i} = fsg{i}(1:length(sg{i}));
end


%%

% for loop to display the mean values of each gauge (combined values) and
% to graph each gauge's values against time.


 
% channel_c_list = zeros(1,length(channels));
% TT = zeros(1,length(channels));
fprintf('\n\n');

%for SG1-6 (1000Hz)
for i = 1:6  
    
    str = ['Strain Gauge ', int2str(i)];
    mean_val = mean(fsg{i});
    min_val = min(fsg{i});
    max_val = max(fsg{i});
    dimm_val = 'um/m';
    fprintf('Gauge = %s, mean value = %.3f %s, range = %.3f\n %s',str,mean_val, dimm_val, max_val - min_val, dimm_val);
    [fsgrf{i}.c,fsgrf{i}.hist,fsgrf{i}.edges,fsgrf{i}.rmm,fsgrf{i}.idx] = rainflow(fsg{i} , t_1000hz); 
    
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
end

% for i = 1: length(c
% TT = array2table(c,'VariableNames',{'Count','Range','Mean','Start','End'});  

% % channel= length(channels{1,1}.data));
%  time_array = (1:length(channels{1,1}.data));
%  
%  [c,hist,edges,rmm,idx] = rainflow(Z,t);
%  
% for i = 1: length(channels{1,1}.data)
%     [c,hist,edges,rmm,idx] = rainflow(Z,t);



