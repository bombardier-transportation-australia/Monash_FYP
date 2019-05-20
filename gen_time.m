function [t] = gen_time(start,step,N)
step_size_in_days = step/(24*3600);
t1 = ones(N, 1) * step_size_in_days;
t2 = [1:N]';
t3 = t1 .* t2;
t4 = (ones(N, 1) * datenum(start));
t = t4 + t3;
t =  datetime(t,'ConvertFrom','datenum');
end

