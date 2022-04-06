function [id] = board2state(grid)   

% da configurazione a valore in base 10

id = 0;
grid_ = zeros(1,9);
cg_ = 1;    % counter grid_

for i = 1:3     % converti grid in vettore 1x9
    for k = 1:3
        grid_(cg_) = grid(i,k);
        cg_ = cg_+1;
    end
end

for i = 1:9     % assegnazione id
    id = id + grid_(i)* 3^(i-1);
end

end