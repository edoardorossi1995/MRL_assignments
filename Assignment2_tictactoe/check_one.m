function [ret] = check_one(matrix)
ret = 0;

[M,N] = size(matrix);
for i = 1:M
    for j = 1:N
        if matrix(i,j) == 1
            ret = ret + 1;
        end
    end
end
end