
% ASSUMING AXLE1 IS FRONT. MB1 SENSORS
% PS1 PRIMARY SUSPENSION PROXIMITY SENSOR FRONT-LEFT (200Hz)
% PS2 PRIMARY SUSPENSION PROXIMITY SENSOR FRONT-RIGHT (200Hz)
% PS3 PRIMARY SUSPENSION PROXIMITY SENSOR REAR-LEFT(200Hz)
% PS4 PRIMARY SUSPENSION PROXIMITY SENSOR REAR-RIGHT(200Hz)
% ACCELEROMETERS ON AXLE 1 (UNSPRUNG MASS)
% ACC1 ACCELEROMETER FRONT-LEFT (VERTICAL) (1000Hz)
% ACC2 ACCELEROMETER FRONT-RIGHT (HORIZONTAL) (1000Hz) (or VERTICAL??)
% ACC3 ACCELEROMETER FRONT-RIGHT (VERTICAL) (1000Hz)
% SS1 SECONDARY SUSPENSION LEFT(200Hz)
% SS2 SECONDARY SUSPENSION RIGHT(200Hz)
% SG1 Caliper Mounting Bracket Front left (1000Hz)
% SG2 Behind Primary Suspension Front left (1000Hz)
% SG3 Top of the Bogie Frame Front Left (1000Hz)
% SG4 Top of the Bogie Frame Front Right (1000Hz)
% SG5 Bottom of the Bogie Frame Right (1000Hz)
% SG6 Bottom of the Bogie Frame Left (1000Hz)
% ASSUMING AXLE1 IS FRONT. TB3 SENSORS
% SS3 SECONDARY SUSPENSION LEFT(200Hz)
% SS4 SECONDARY SUSPENSION RIGHT(200Hz)

% ASSUMING AXLE1 IS FRONT. MB3 SENSORS
% SS5 SECONDARY SUSPENSION LEFT(200Hz)
% SS6 SECONDARY SUSPENSION RIGHT(200Hz)

% Speed (from wheels) signal (200Hz)
clear


allocateMemory;
accumulateData;
filterStrainGauges;
% performRainflow;
% performMinersElementary;
figure;
hold on;
fsg{1} = fsg{1} - mean(fsg{1}) -9;
plot(fsg{1})
fsg{2} = fsg{2} - mean(fsg{2}) + 72.6;
plot(fsg{2})
fsg{3} = fsg{3} - mean(fsg{3}) + 8;
plot(fsg{3})
fsg{4} = fsg{4} - mean(fsg{4}) + 8;
plot(fsg{4})
fsg{5} = fsg{5} - mean(fsg{5}) + 58.6;
plot(fsg{5})
fsg{6} = fsg{6} - mean(fsg{6}) + 58.6;
plot(fsg{6})
legend('1','2','3','4','5','6');
%% Total kilometres




