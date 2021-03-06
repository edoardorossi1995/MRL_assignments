clc
close all
clear variables

load policy_file.mat
load data.mat


figure
plot([.5 3.5],[-1.5 -1.5], 'k','linewidth',2);
hold on
plot([.5 3.5],[-2.5 -2.5], 'k','linewidth',2)
plot([1.5 1.5],[-.5 -3.5], 'k','linewidth',2)
plot([2.5 2.5],[-.5 -3.5], 'k','linewidth',2)
hold off
axis off


grid = [0,0,0; 0,0,0; 0,0,0];
plotgame(grid)

while win_condition(grid) == 0 

    % agent - 1
    id = board2state(grid)
    s = board2state(grid);
    grid = azione_value(grid, policy(find(vS == s)),1)
    plotgame(grid)
    
    wcg = win_condition(grid);
    
    % check su vittoria X o pareggio
    if wcg ~= 0
        break
    end

    % oppo - 1
    id = board2state(grid)

    answer=inputdlg('Seleziona mossa valida:','Input',[1 35]);
    a = str2double(answer{1});

    grid = azione_value(grid,a,2)
    id = board2state(grid)
    
    plotgame(grid)
    pause(0.5)

    
end