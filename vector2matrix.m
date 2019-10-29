function [ y ] = vector2matrix( x, col, rowwise)
% converts vector to matrix

if isrow(x')
        x = x';
    end
    if mod(length(x),col) ~= 0 
        appn = ceil(length(x)/col) * col - length(x);
        x = [x,zeros(1,appn)];
    end
    if rowwise
        x = reshape(x,[],length(x)/col)';
    else
        x = reshape(x,[],col);
    end
    y = x;
end

