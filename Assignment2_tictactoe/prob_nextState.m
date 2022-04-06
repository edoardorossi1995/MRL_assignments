function [prob] = prob_nextState(grid)

n_zero = check_zero(grid);
if n_zero ~= 0
    prob = 1/n_zero;
else
    prob = 0;
end

end