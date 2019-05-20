clear

[filename, pathname] = uigetfile({'*.dwh'},'Select record file' ,'MultiSelect', 'on');

gps_date = [];
gps_time = [];
gps_latitude = [];
gps_longitude = [];
gps_speed = [];

ps1  = [];
ps2  = [];
ps3  = [];
ps4  = [];
%
ss1  = [];
ss2  = [];
ss3  = [];
ss4  = [];
ss5  = [];
ss6  = [];

%Sensor gauges
sg7  = [];
sg8  = [];
sg9  = [];
sg10  = [];
sg11  = [];
sg12  = [];
sg13  = [];
sg14  = [];
sg15  = [];
sg16  = [];

speed  = [];
sg1  = [];
sg2  = [];
sg3  = [];
sg4  = [];
sg5  = [];
sg6  = [];

acc1  = [];
acc2  = [];
acc3  = [];


% % for loop to add every dwh file after the first one into a combined answer
% % which fits into channels.data
for i = 1: length(filename)

    Data_string  = [pathname , '\', filename{i}]

    [channels, fileheader] = loadDWHv4(Data_string);  
    if fileheader.ftast == 1
        gps_date = [gps_date;channels{1}.data];
        gps_time = [gps_time;channels{2}.data];
        gps_latitude = [gps_latitude;channels{3}.data];
        gps_longitude = [gps_longitude;channels{4}.data];
        gps_speed = [gps_speed;channels{5}.data];
    end
    
    if fileheader.ftast == 200
    %proximity sensors
        ps1  = [ps1; channels{1}.data];
        ps2  = [ps2; channels{2}.data];
        ps3  = [ps3; channels{3}.data];
        ps4  = [ps4; channels{4}.data];
        %
        ss1  = [ss1; channels{5}.data];
        ss2  = [ss2; channels{6}.data];
        ss3  = [ss3; channels{7}.data];
        ss4  = [ss4; channels{8}.data];
        ss5  = [ss5; channels{9}.data];
        ss6  = [ss6; channels{10}.data];

        %Sensor gauges
        sg7  = [sg7; channels{14}.data];
        sg8  = [sg8; channels{15}.data];
        sg9  = [sg9; channels{16}.data];
        sg10  = [sg10; channels{17}.data];
        sg11  = [sg11; channels{18}.data];
        sg12  = [sg12; channels{19}.data];
        sg13  = [sg13; channels{20}.data];
        sg14  = [sg14; channels{21}.data];
        sg15  = [sg15; channels{22}.data];
        sg16  = [sg16; channels{23}.data];

        speed  = [speed; channels{12}.data];
    end
    
    %for 1000Hz files
    if fileheader.ftast == 1000 && fileheader.AzCh == 6
        sg1  = [sg1; channels{1}.data];
        sg2  = [sg2; channels{2}.data];
        sg3  = [sg3; channels{3}.data];
        sg4  = [sg4; channels{4}.data];
        sg5  = [sg5; channels{5}.data];
        sg6  = [sg6; channels{6}.data];
    end
    
    if fileheader.ftast == 1000 && fileheader.AzCh == 3
        acc1  = [acc1; channels{1}.data];
        acc2  = [acc2; channels{2}.data];
        acc3  = [acc3; channels{3}.data];
    end
    
end
 
