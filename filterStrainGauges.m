%% FilterStrainGauges
load('LPFNum200Hz.mat');
load('LPFNum1000Hz.mat');

%create "filtered" sensor gauges
f = waitbar(0, 'filtering strain gauges');
for i = 1:6
    fsg{i} = conv(sg{i},Num1000Hz);
    fsg{i} = fsg{i}(1:length(sg{i}));
    waitbar(i/6,f);
end

for i = 7:16
    fsg{i} = conv(sg{i},Num200Hz);
    fsg{i} = fsg{i}(1:length(sg{i}));
    waitbar((i-6)/6,f);
end
clear sg
close(f)