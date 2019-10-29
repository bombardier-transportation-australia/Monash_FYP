% file used to read dwh files

clear
[file,folder] = uigetfile('*.dwh');
fullpath = fullfile(folder, file);
[channels, fileheader] = loadDWHv4(fullpath); 

if fileheader.ftast == 1
    len = length(channels{1}.data);
    rt = [0:1/fileheader.ftast:(len -1)*1/fileheader.ftast];
    t_1hz = fileheader.t';
    gps_date = channels{1}.data;
    gps_time = channels{2}.data;
    gps_latitude = channels{3}.data;
    gps_longitude = channels{4}.data;
    gps_speed = channels{5}.data;
end

%For 200Hz %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if fileheader.ftast == 200
    len = length(channels{1}.data);
    rt = [0:1/fileheader.ftast:(len -1)*1/fileheader.ftast];
    t_200hz = fileheader.t';
    %Primary Suspension Proximity Sensors
    for  j = 1 : 4
        ps{j} = channels{j}.data;
    end
    for j = 1 : 6
        ss{j} = channels{j + 5}.data;
    end
    sg{7} = channels{14}.data;
    for j = 8 :16
        sg{j} = channels{j + 7}.data;
    end
    acc4 = channels{11}.data;
    speed = channels{12}.data;
    
end

%for 1000Hz files %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if fileheader.ftast == 1000 && fileheader.AzCh == 6
    len = length(channels{1}.data);
    rt = [0:1/fileheader.ftast:(len -1)*1/fileheader.ftast];
    t_1000hz = fileheader.t';
    %Sensor gauges (bogies)
    for j = 1:6
        sg{j} = channels{j}.data;
    end
    hold on;
    plot(rt,sg{1});
    plot(rt,sg{2});
    plot(rt,sg{3});
    plot(rt,sg{4});
%     plot(rt,sg{5});
    plot(rt,sg{6});
    hold off;
    legend('SG1','SG2','SG3','SG4','SG6');
%     legend('SG1','SG2','SG3','SG4','SG5','SG6')
    xlabel('time(s)');
    ylabel('strain um/m');
end

%for 2000Hz files %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if fileheader.ftast == 1000 && fileheader.AzCh == 3
    t_2000hz = fileheader.t';
    len = length(channels{1}.data);
    rt = [0:1/fileheader.ftast:(len -1)*1/fileheader.ftast];
    acc1 = channels{1}.data;
    acc2 = channels{2}.data;
    acc3 = channels{3}.data;
    hold on;
    plot(rt,acc1);
    plot(rt,acc2);
    plot(rt,acc3);
    hold off;
    legend('ACC1','ACC2','ACC3');
    xlabel('time(s)');
    ylabel('acceleration ms^-2');
end

