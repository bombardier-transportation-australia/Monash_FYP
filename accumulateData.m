%% Accumulate data
%accumulate instrumentation data

position_1hz = 1;
position_200hz = 1;
position_1000hz = 1;
position_2000hz = 1;
f = waitbar(0, 'loading files');
for i = 1: height(files)

    path  = [files.folder{i} , '\', files.name{i}];

    [channels, fileheader] = loadDWHv4(path);  
    %For 1Hz %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
    %For 200Hz %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
        sg{7}(position_200hz:position_200hz + record_length -1) = channels{14}.data * 167000e-6;
        for j = 8 :16
            sg{j}(position_200hz:position_200hz + record_length -1) = channels{j + 7}.data * 210000e-6;
        end
        acc4(position_200hz:position_200hz + record_length -1) = channels{11}.data;
        speed(position_200hz:position_200hz + record_length -1) = channels{12}.data;
        
        

        position_200hz = position_200hz + record_length;
    end
    %for 1000Hz files %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if fileheader.ftast == 1000 && fileheader.AzCh == 6
        record_length = length(channels{1}.data);

        t_1000hz(position_1000hz:position_1000hz + record_length - 1) = fileheader.t';
        %Sensor gauges (bogies)
        for j = 1:6
            sg{j}(position_1000hz:position_1000hz + record_length -1) = channels{j}.data * 167000e-6;
        end
                
        position_1000hz = position_1000hz + record_length;
    end
    %for 2000Hz files %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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

clear channels fileheader files folder position_*hz length_*hz
close(f);