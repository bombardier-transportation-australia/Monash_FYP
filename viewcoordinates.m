[filename, pathname] = uigetfile({'*.dwh'},'Select record file');
Data_Path = [pathname, '\' , filename];
[channels, fileheader] = loadDWHv4(Data_Path);

