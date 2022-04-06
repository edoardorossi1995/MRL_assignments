function [grid] = azione_value(grid,a,value)     % con if, funziona

if (a == 1)
    grid = azione_sing(grid,1,1,value);
elseif (a == 2)
    grid = azione_sing(grid,1,2,value);
elseif (a == 3)
    grid = azione_sing(grid,1,3,value);
elseif (a == 4)
    grid = azione_sing(grid,2,1,value);
elseif (a == 5)
    grid = azione_sing(grid,2,2,value);
elseif (a == 6)
    grid = azione_sing(grid,2,3,value);
elseif (a == 7)
    grid = azione_sing(grid,3,1,value);
elseif (a == 8)
    grid = azione_sing(grid,3,2,value);
elseif (a == 9)
    grid = azione_sing(grid,3,3,value);
end

end