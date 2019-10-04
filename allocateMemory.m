%% AllocateMemory
%Let user select root folder

%TODO: ADD ABILITY TO HAVE MULTIPLE ROOT FOLDERS SO THAT A WEEK'S WORTH OF
%DATA CAN BE SELECTED
% folder = uigetdir('.');
folder = uigetdir('E:\DATA\6004 2014 10 28\Data');

%Make a table with all the .dwh files contained within the root folder,
%including subfolders
files = struct2table(dir([folder,'\**\*.dwh']));

%initialise record file length variables
length_1hz = 0;
length_200hz = 0;
length_1000hz = 0;
length_2000hz = 0;
f = waitbar(0, 'loading headers');

%read headers to preassign memory space
for i=1:height(files)
    path  = [files.folder{i} , '\', files.name{i}];
    %load the header of each file
    [~,fileheader] = loadDWHv4(path,1);
    %store the timestamp for each file in MATLAB datenum format in the
    %files table
    if ~isempty(fileheader)
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
    end
    waitbar(i/height(files),f);
end
close(f);
%approximate total lengths. A padding of 0.1% is added because samplesPerCh
%is innacurate
length_1hz = ceil(length_1hz * 1.001);
length_200hz = ceil(length_200hz * 1.001);
length_2000hz = ceil(length_2000hz * 1.001);
length_1000hz = ceil(length_1000hz * 1.001);
clear datestring i fileheader
%sort files by timestamp
files = sortrows(files, 'datenum'); 


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
    ss{i} = zeros(length_1000hz, 0);
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


