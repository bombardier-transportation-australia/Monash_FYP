


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
ps1  = zeros(length_200hz, 0);
ps2  = zeros(length_200hz, 0);
ps3  = zeros(length_200hz, 0);
ps4  = zeros(length_200hz, 0);
%
ss1  = zeros(length_200hz, 0);
ss2  = zeros(length_200hz, 0);
ss3  = zeros(length_200hz, 0);
ss4  = zeros(length_200hz, 0);
ss5  = zeros(length_200hz, 0);
ss6  = zeros(length_200hz, 0);

%Sensor gauges
sg7  = zeros(length_200hz, 0);
sg8  = zeros(length_200hz, 0);
sg9  = zeros(length_200hz, 0);
sg10  = zeros(length_200hz, 0);
sg11  = zeros(length_200hz, 0);
sg12  = zeros(length_200hz, 0);
sg13  = zeros(length_200hz, 0);
sg14  = zeros(length_200hz, 0);
sg15  = zeros(length_200hz, 0);
sg16  = zeros(length_200hz, 0);

t_1000hz = zeros(length_1000hz, 0);
speed  = zeros(length_1000hz, 0);
acc4  = zeros(length_1000hz, 0);
sg1  = zeros(length_1000hz, 0);
sg2  = zeros(length_1000hz, 0);
sg3  = zeros(length_1000hz, 0);
sg4  = zeros(length_1000hz, 0);
sg5  = zeros(length_1000hz, 0);
sg6  = zeros(length_1000hz, 0);

t_2000hz = zeros(length_2000hz, 0);
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
        ps1(position_200hz:position_200hz + record_length -1) = channels{1}.data;
        ps2(position_200hz:position_200hz + record_length -1) = channels{2}.data;
        ps3(position_200hz:position_200hz + record_length -1) = channels{3}.data;
        ps4(position_200hz:position_200hz + record_length -1) = channels{4}.data;
        
        ss1(position_200hz:position_200hz + record_length -1) = channels{5}.data;
        ss2(position_200hz:position_200hz + record_length -1) = channels{6}.data;
        ss3(position_200hz:position_200hz + record_length -1) = channels{7}.data;
        ss4(position_200hz:position_200hz + record_length -1) = channels{8}.data;
        ss5(position_200hz:position_200hz + record_length -1) = channels{9}.data;
        ss6(position_200hz:position_200hz + record_length -1) = channels{10}.data;
        
        acc4(position_200hz:position_200hz + record_length -1) = channels{11}.data;
        speed(position_200hz:position_200hz + record_length -1) = channels{12}.data;
        
        sg7(position_200hz:position_200hz + record_length -1) = channels{14}.data;
        sg8(position_200hz:position_200hz + record_length -1) = channels{15}.data;
        sg9(position_200hz:position_200hz + record_length -1) = channels{16}.data;
        sg10(position_200hz:position_200hz + record_length -1) = channels{17}.data;
        sg11(position_200hz:position_200hz + record_length -1) = channels{18}.data;
        sg12(position_200hz:position_200hz + record_length -1) = channels{19}.data;
        sg13(position_200hz:position_200hz + record_length -1) = channels{20}.data;
        sg14(position_200hz:position_200hz + record_length -1) = channels{21}.data;
        sg15(position_200hz:position_200hz + record_length -1) = channels{22}.data;
        sg16(position_200hz:position_200hz + record_length -1) = channels{23}.data;

        position_200hz = position_200hz + record_length;
    end
    %for 1000Hz files
    if fileheader.ftast == 1000 && fileheader.AzCh == 6
        record_length = length(channels{1}.data);

        t_1000hz(position_1000hz:position_1000hz + record_length - 1) = fileheader.t';
        %Sensor gauges (bogies)
        sg1(position_1000hz:position_1000hz + record_length -1) = channels{1}.data;
        sg2(position_1000hz:position_1000hz + record_length -1) = channels{2}.data;
        sg3(position_1000hz:position_1000hz + record_length -1) = channels{3}.data;
        sg4(position_1000hz:position_1000hz + record_length -1) = channels{4}.data;
        sg5(position_1000hz:position_1000hz + record_length -1) = channels{5}.data;
        sg6(position_1000hz:position_1000hz + record_length -1) = channels{6}.data;
                
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
fsg1 = conv(sg1,Num1000Hz);
fsg1 = fsg1(1:length(sg1));

fsg2 = conv(sg2,Num1000Hz);
fsg2 = fsg2(1:length(sg2));

fsg3 = conv(sg3,Num1000Hz);
fsg3 = fsg3(1:length(sg3));

fsg4 = conv(sg4,Num1000Hz);
fsg4 = fsg4(1:length(sg4));

fsg5 = conv(sg5,Num1000Hz);
fsg5 = fsg5(1:length(sg5));

fsg6 = conv(sg6,Num1000Hz);
fsg6 = fsg6(1:length(sg6));




fsg7 = conv(sg7,Num200Hz);
fsg7 = fsg7(1:length(sg7));

fsg8 = conv(sg8,Num200Hz);
fsg8 = fsg8(1:length(sg8));

fsg9 = conv(sg9,Num200Hz);
fsg9 = fsg9(1:length(sg9));

fsg10 = conv(sg10,Num200Hz);
fsg10 = fsg10(1:length(sg10));

fsg11 = conv(sg11,Num200Hz);
fsg11 = fsg11(1:length(sg11));

fsg12 = conv(sg12,Num200Hz);
fsg12 = fsg12(1:length(sg12));

fsg13 = conv(sg13,Num200Hz);
fsg13 = fsg13(1:length(sg13));

fsg14 = conv(sg14,Num200Hz);
fsg14 = fsg14(1:length(sg14));

fsg15 = conv(sg15,Num200Hz);
fsg15 = fsg15(1:length(sg15));

fsg16 = conv(sg16,Num200Hz);
fsg16 = fsg16(1:length(sg16));
%%
% 
% % for loop to display the mean values of each gauge (combined values) and
% % to graph each gauge's values against time.
% 
% time_array = (1:length(channels{1,1}.data));
%  
% % channel_c_list = zeros(1,length(channels));
% TT = zeros(1,length(channels));
% fprintf('\n\n');
% 
% for i = 1:length(channels)  
%     
%     str = channels{i}.Ch_Alias;
%     mean_val = mean(channels{i,1}.data);
%     min_val = min(channels{i,1}.data);
%     max_val = max(channels{i,1}.data);
%     dimm_val = channels{i}.Ch_Dimension;
%     fprintf('Gauge = %s, mean value = %.3f %s, range = %.3f\n',str,mean_val,dimm_val, max_val - min_val);
%     figure
%     plot( channels{i,1}.data);
%     title(str);
%     ylabel(dimm_val);   
%     
%     [c,hist,edges,rmm,idx] = rainflow(channels{i,1}.data , time_array);
% %     TT(i) = array2table(c,'VariableNames',{'Count','Range','Mean','Start','End'});  
%     TT = array2table(c,'VariableNames',{'Count','Range','Mean','Start','End'});  
%     
% end
% 
% % for i = 1: length(c
% % TT = array2table(c,'VariableNames',{'Count','Range','Mean','Start','End'});  
% 
% % % channel= length(channels{1,1}.data));
% %  time_array = (1:length(channels{1,1}.data));
% %  
% %  [c,hist,edges,rmm,idx] = rainflow(Z,t);
% %  
% % for i = 1: length(channels{1,1}.data)
% %     [c,hist,edges,rmm,idx] = rainflow(Z,t);
% 
% 
% 