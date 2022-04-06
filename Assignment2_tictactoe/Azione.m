function [grid] = Azione(grid,a)     % con if, funziona

if (a == 1)
    grid = azione_agente(grid,1,1);
elseif (a == 2)
    grid = azione_agente(grid,1,2);
elseif (a == 3)
    grid = azione_agente(grid,1,3);
elseif (a == 4)
    grid = azione_agente(grid,2,1);
elseif (a == 5)
    grid = azione_agente(grid,2,2);
elseif (a == 6)
    grid = azione_agente(grid,2,3);
elseif (a == 7)
    grid = azione_agente(grid,3,1);
elseif (a == 8)
    grid = azione_agente(grid,3,2);
elseif (a == 9)
    grid = azione_agente(grid,3,3);
end

end