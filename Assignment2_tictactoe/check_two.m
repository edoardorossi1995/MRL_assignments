function [ret] = check_two(matrix)
ret = 0;

[M,N] = size(matrix);
for i = 1:M
    for j = 1:N
        if matrix(i,j) == 2
            ret = ret + 1;
        end
    end
end
end


