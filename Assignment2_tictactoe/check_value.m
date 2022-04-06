function [ret] = check_value(matrix, value)

ret = 0;

[M,N] = size(matrix);
for i = 1:M
    for j = 1:N
        if matrix(i,j) == value
            ret = ret + 1;
        end
    end
end

end