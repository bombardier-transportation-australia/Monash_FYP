% hold on


% plot(t_1000hz,fsg{1})
% plot(t_1000hz,fsg{2})
% plot(t_1000hz,fsg{3})
% plot(t_1000hz,fsg{4})
% % plot(t_1000hz,fsg{5})
% plot(t_1000hz,fsg{6})
% plot(t_200hz,speed)
% plot(t_1hz,gps_speed)

% legend('sg1','sg2','sg3','sg4','sg6','speed','gps speed');

t = decimate(t_200hz,0.01);
sss = decimate(ss{2},0.01);

tdate = datetime(t,'ConvertFrom','datenum');
plot(tdate,sss)