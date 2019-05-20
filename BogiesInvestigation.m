raw_data_path = 'C:\Users\Jerin\Desktop\Bombardier\Sample Data\20180209_142334';
pathAcc =  [raw_data_path,'\**\Data_2000Hz_*.dwh'];
pathGPS = [raw_data_path,'\**\Data_1Hz_*.dwh'];

f = waitbar(0,'Now converting...');

%LOAD UP GPS COORDINATES
pathGPS = dir(pathGPS);

for i = 1: length(pathGPS)
    cellsGPS{i,1} = pathGPS(i).name;
    cellsGPS{i,2} = pathGPS(i).folder;
    cellsGPS{i,3} = pathGPS(i).datenum;
end

cellsGPS = sortrows(cellsGPS,[2,1]);

gps_datetime = zeros(1,1);
gps_latitude = zeros(1,1);
gps_longitude = zeros(1,1);

path = [cellsGPS{1,2},'\',cellsGPS{1,1}];
[channels, fileheader] = loadDWHv4(path);
a = [num2str(channels{1,1}.data),repmat(' ',[length(channels{1,1}.data),1]), num2str(channels{2,1}.data)];
t = datetime(a,'InputFormat','yyyyMMdd HHmmss');
start_datetime = datetime([fileheader.Date, ' ', fileheader.Time],'InputFormat','yy.MM.dd HH:mm:ss');
gps_datetime = t;
gps_latitude = channels{4,1}.data;
gps_longitude = channels{3,1}.data;
gps_speed = channels{5,1}.data;
info.gps_sampling_rate = fileheader.ftast;

for i =1 : length (cellsGPS)
    path = [cellsGPS{i,2},'\',cellsGPS{i,1}];
    [channels, fileheader] = loadDWHv4(path);
    start_datetime = datetime([fileheader.Date, ' ', fileheader.Time],'InputFormat','yy.MM.dd HH:mm:ss');
    t = gen_time(start_datetime,1/fileheader.ftast,length(channels{1,1}.data));
    gps_datetime = [gps_datetime;t];
    gps_latitude = [gps_latitude;channels{4,1}.data];
    gps_longitude = [gps_longitude;channels{3,1}.data];
    gps_speed = [gps_speed;channels{5,1}.data];
    waitbar(i/length(cellsGPS),f,'Now converting...');
end
close(f);

f = waitbar(0,'Now converting...');
%LOAD UP ACCELERATIONS
pathAcc = dir(pathAcc);

for i = 1: length(pathAcc)
    cellsAcc{i,1} = pathAcc(i).name;
    cellsAcc{i,2} = pathAcc(i).folder;
    cellsAcc{i,3} = pathAcc(i).datenum;
end


cellsAcc = sortrows(cellsAcc,[2,1]);


path = [cellsAcc{1,2},'\',cellsAcc{1,1}];
[channels, fileheader] = loadDWHv4(path);
start_datetime = datetime([fileheader.Date, ' ', fileheader.Time],'InputFormat','yy.MM.dd HH:mm:ss');
t = gen_time(start_datetime,1/fileheader.ftast,length(channels{1,1}.data));
Acc_Datetime = t;
Acc_Left_Vertical = channels{1,1}.data;
Acc_Lateral = channels{2,1}.data;
Acc_Right_Vertical = channels{3,1}.data;
info.acc_sampling_rate = fileheader.ftast;
for i = 2 :length (cellsAcc)
    path = [cellsAcc{i,2},'\',cellsAcc{i,1}];
    [channels, fileheader] = loadDWHv4(path);
    start_datetime = datetime([fileheader.Date, ' ', fileheader.Time],'InputFormat','yy.MM.dd HH:mm:ss');
    t = gen_time(start_datetime,1/fileheader.ftast,length(channels{1,1}.data));
    Acc_Datetime = [Acc_Datetime;t];
    Acc_Left_Vertical = [Acc_Left_Vertical;channels{1,1}.data];
    Acc_Lateral = [Acc_Lateral;channels{2,1}.data];
    Acc_Right_Vertical = [Acc_Right_Vertical;channels{3,1}.data];
    waitbar(i/length(cellsAcc),f,'Now converting...');
end
close(f);

save([raw_data_path,'\6004 R96.mat'], ...
'Acc_Left_Vertical','Acc_Lateral','Acc_Right_Vertical', ...
'Acc_Datetime', ...
'gps_latitude','gps_longitude','gps_datetime','gps_speed');
clear a cellsAcc cellsGPS f fileheader channels i pathAcc pathGPS raw_data_path
clear start_datetime t 

