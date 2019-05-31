function y = decimate(x,factor)

    y = x(1:1/factor:end);
end