
function [channels, fileheader] = loadDWHv4(Data_Path, varargin)

%CATCH ERRORS USING ERROR HANDLING

try
headerOnly = 0;
if length(varargin) == 1
    headerOnly = varargin{1};
elseif length(varargin) > 1
    ME = MException('FunctionError','Too many arguments');
    throw(ME);
end
fileDetails = dir(Data_Path);

% channels = cell(0,0);
% fileheader = cell(0,0);
if fileDetails.bytes < 4
    ME = MException('VerifyFile:invalidFile','The offset is invalid');
    throw(ME);
end
fileID = fopen(Data_Path);
fseek(fileID,0, 'bof');
headerOffset =  int32(fread(fileID,1,'int32','ieee-be'));
headerOffset = headerOffset + 4;
%%Read header (file specifications)

if fileDetails.bytes < headerOffset
    ME = MException('VerifyFile:invalidFile','The header is not big enough');
    throw(ME);
end
fileheader = struct('IP','','Filename','','Date','','Time','','AzCh',0,'SamplesPerCh',0,'ftast',0);
tline = fgetl(fileID);
if length(tline) ~= 13 %check first line is valided
    ME = MException('VerifyFile:invalidFile','The header is corrupted');
    throw(ME);
end
tline = fgetl(fileID);
[~,val] = strtok(tline, '=');
fileheader.IP = val(2:end);
tline = fgetl(fileID);
[~,val] = strtok(tline, '=');
fileheader.Filename = val(2:end);
tline = fgetl(fileID);
[~,val] = strtok(tline, '=');
fileheader.Date = val(2:end);
tline = fgetl(fileID);
[~,val] = strtok(tline, '=');
fileheader.Time = val(2:end);
tline = fgetl(fileID);
[~,val] = strtok(tline, '=');
fileheader.AzCh = str2double(val(2:end));
tline = fgetl(fileID);
[~,val] = strtok(tline, '=');
fileheader.SamplesPerCh = str2double(val(2:end));
tline = fgetl(fileID);
[~,val] = strtok(tline, '=');
fileheader.ftast = str2double(val(2:end));

channels = cell(fileheader.AzCh,1);
channels{1} = struct('Ch_Alias','','Ch_Gain',0.0,'ModuleType',0,'Ch_Zero',0.0,'Ch_Dimension','','LSBWeight',0,'Offset',0);
i = 1;
%read the channel specifications line by line
for i = 1 : fileheader.AzCh
    tline = fgetl(fileID);
    tline = fgetl(fileID);
    [~,val] = strtok(tline, '=');
    channels{i}.Ch_Alias = val(2:end);
    tline = fgetl(fileID);
    [~,val] = strtok(tline, '=');
    channels{i}.Ch_Gain = str2double(val(2:end));
    tline = fgetl(fileID);
    [~,val] = strtok(tline, '=');
    channels{i}.ModuleType = str2double(val(2:end));
    tline = fgetl(fileID);
    [~,val] = strtok(tline, '=');
    channels{i}.Ch_Zero = str2double(val(2:end));
    tline = fgetl(fileID);
    [~,val] = strtok(tline, '=');
    channels{i}.Ch_Dimension = val(2:end);
    tline = fgetl(fileID);
    [~,val] = strtok(tline, '=');
    channels{i}.LSBWeight = str2double(val(2:end));
    tline = fgetl(fileID);
    [~,val] = strtok(tline, '=');
    channels{i}.Offset = str2double(val(2:end));
    
end
if ~headerOnly
    %if reading interval is such then do it one way
    azch = fileheader.AzCh;
    samplesPerCh = fileheader.SamplesPerCh;
    %calculate reading interval
    rowCount = round(100000/azch);

%     if fileDetails.bytes < headerOffset + rowCount* azch %check binary part
%         ME = MException('VerifyFile:invalidFile','The binary part is corrupted');
%         throw(ME);
%     end


    %move away from the header into binary data
    fseek(fileID,headerOffset, 'bof');
    
    

    %process sensors into readable data
    if azch * samplesPerCh > 100000
        %big endian read
        A = int32(fread(fileID,inf,'int32','ieee-be'));
        %close file 
        fclose(fileID);
        %define whether we're reading a small or large file
        rowwise = 1;
        %reorganise data by channel
        rawMatrix = vector2matrix(A,azch,rowwise);
        % clear A
        % should LSBWeight be an unsigned integer?%%%%
        for i = 1 : azch
        channels{i}.data = binary2nominal(rawMatrix(:,i),channels{i}.LSBWeight,channels{i}.Offset,channels{i}.ModuleType) * channels{i}.Ch_Gain - channels{i}.Ch_Zero;
        end
    else
        %big endian read
        A = fread(fileID,inf,'double','ieee-be');
        %close file 
        fclose(fileID);
        %define whether we're reading a small or large file
        rowwise = 1;
        rawMatrix = vector2matrix(A,azch,rowwise);
        for i = 1 : azch
        channels{i}.data = rawMatrix(:,i);
        end
    end

    
    clear rawMatrix A tline val i filepath filefolder Data_Path rowwise fileID
else
    fclose(fileID);
end
catch ME
    if strcmp(ME.identifier,'VerifyFile:invalidFile')
        channels = cell(0,0);
        fileheader = cell(0,0);
    else
        rethrow(ME);
    end
end
