% Funzione per la plot del TTT

function  plotgame(grid)

hold on;
for row = 1:3
    for col = 1:3
        if(grid(row,col)==1)
            text(col,-row,'X','horizontalalignment','center','fontsize',45);
        elseif (grid(row,col) ==2)
            text(col,-row,'O','horizontalalignment','center','fontsize',45);
        else
            text(col,-row,'','horizontalalignment','center','fontsize',20);
        end
    end
end
end