% close all;
% 
%% SG1, SG2
%11
% figure
% plot(t_1000hz,sg{1})
% hold on 
% plot(t_1000hz, sg{2})
% % plot(t_200hz, speed)
% hold off
% % legend('sg 1','sg 2','speed')
% legend('sg 1','sg 2');
% title('SG1 & SG2');

%% SPEED
plot(t_200hz, speed)
legend('speed')

% % SG3, SG4, SPEED
% figure
% plot(t_1000hz,sg{3})
% hold on 
% plot(t_1000hz, sg{4})
% plot(t_200hz, speed)
% hold off
% % legend('sg 3','sg 4','speed')
% legend('sg 3','sg 4');
% title('SG3 & SG4');

% 
% %% SG5, SG6, SPEED
% figure
% plot(t_1000hz,sg{5})
% hold on 
% plot(t_1000hz,sg{6})
% plot(t_200hz, speed)
% hold off
% 
% legend('sg 5','sg 6','speed')
% title('SG5 & SG6');

%111
% SG3, SG4, SG5, SG6, SPEED
% figure
% plot(t_1000hz,sg{3})
% hold on 
% plot(t_1000hz, sg{4})
% plot(t_1000hz,sg{5})
% plot(t_1000hz,sg{6})
% % plot(t_200hz, speed)
% hold off
% legend('sg 3','sg 4','sg 5','sg 6')


% figure;
% hold on;
% plot(sg{1})
% plot(sg{2})
% plot(sg{3})
% plot(sg{4})
% plot(sg{5})
% plot(sg{6})
% 
% for i = 1:6      
%     str = ['Strain Gauge ', int2str(i)];
%     mean_val = mean(sg{i});
%     min_val = min(sg{i});
%     max_val = max(sg{i});
%     dimm_val = 'um/m';
%     fprintf('Gauge = %s, mean value = %.3f %s, range = %.3f %s\n',str,mean_val, dimm_val, max_val - min_val, dimm_val);
% end
%     
% fprintf('\n');

