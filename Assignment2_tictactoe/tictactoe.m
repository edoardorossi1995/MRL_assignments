close all
clear variables
clc



S_tot = 3^9;
a0 = 9;


% riduzione stati

S = [0:S_tot-1];
num_S = length(S)
vS = [];    % valid states

for i=0:(length(S)-1)
    
    grid = state2board(i);
    n1 = check_one(grid);   % X
    n2 = check_two(grid);   % O
    if n2 == n1
        vS = [vS, i];
    end
    vS;
end

num_vS = length(vS)

%%  matrice P

%POTREBBE ESSERCI UN ERRORE GIGANTE => RIVEDI DIMENSIONE FIND
P = zeros(num_vS+1, num_vS+1 , a0);

for s = 1:num_vS    % indice stato di partenza s
    
    for a = 1:a0    % scelta dell'azione a
                
        grid = state2board(vS(s));
        grid = Azione(grid,a);        
        empty_index = find(transpose(grid) == 0); % questo perché il find cicla per colonne
        probAS = prob_nextState(grid);
        
        for i=1:length(empty_index)
            grid_ = grid;
            grid_ = A_oppo(grid_,empty_index(i));
            id = board2state(grid_);
            index_id = find(vS == id);
            P(s,index_id,a) = probAS;                                   
        end 
        
    end    
    
end


%% matrice R

R = zeros(num_vS+1, a0);

for s = 1:num_vS    % indice stato di partenza s
    
    for a = 1:a0    % scelta dell'azione a
        
        grid = state2board(vS(s));
        
        cg_ = 1;    % counter grid_
        
        for i = 1:3     % converti grid in vettore 1x9
            for k = 1:3
                grid_(cg_) = grid(i,k);
                cg_ = cg_+1;
            end
        end
        
        prev = grid_(a);
        if (prev == 1 || prev == 2) % se sovrascrive
            R(s,a) = -1000;
            
        elseif prev == 0
            grid = Azione(grid,a);
            
            ret = win_condition(grid);
            
            if ret == 1 
                R(s,a) = 1;     % se vince 
            elseif ret == -1
                R(s,a) = -1;   % se perde
            elseif ret == -1
                cz = check_zero(grid);
                if cz == 0
                    R(s,a) = 0;      % se pareggia
                end
                
                
            end
        end
    end
end

%%

save data.mat P R vS

%%

function [grid]  = azione_agente(grid,i,j)

%il valore di ritorno è l'aggiornamento della griglia

grid(i,j) = 1;

end

function [grid]  = azione_oppo(grid,i,j)

%il valore di ritorno è l'aggiornamento della griglia

grid(i,j) = 2;

end

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

function [grid] = A_oppo(grid,a)     % con if, funziona

if (a == 1)
    grid = azione_oppo(grid,1,1);
elseif (a == 2)
    grid = azione_oppo(grid,1,2);
elseif (a == 3)
    grid = azione_oppo(grid,1,3);
elseif (a == 4)
    grid = azione_oppo(grid,2,1);
elseif (a == 5)
    grid = azione_oppo(grid,2,2);
elseif (a == 6)
    grid = azione_oppo(grid,2,3);
elseif (a == 7)
    grid = azione_oppo(grid,3,1);
elseif (a == 8)
    grid = azione_oppo(grid,3,2);
elseif (a == 9)
    grid = azione_oppo(grid,3,3);
end

end

function [out] = win_condition(grid)

out = 0;    % gioco continua

if (grid(1,1) == 1 && grid(1,2) == 1 && grid(1,3) == 1) || ...
        (grid(2,1) == 1 && grid(2,2) == 1 && grid(2,3) == 1) || ...
        (grid(3,1) == 1 && grid(3,2) == 1 && grid(3,3) == 1) || ...
        (grid(1,1) == 1 && grid(2,1) == 1 && grid(3,1) == 1) || ...
        (grid(1,2) == 1 && grid(2,2) == 1 && grid(3,2) == 1) || ...
        (grid(1,3) == 1 && grid(2,3) == 1 && grid(3,3) == 1) || ...
        (grid(1,1) == 1 && grid(2,2) == 1 && grid(3,3) == 1) || ...
        (grid(3,1) == 1 && grid(2,2) == 1 && grid(1,3) == 1) % condizioni di vittoria
    out = 1;    %vittoria
else % condizioni di sconfitta
    if (check_zero(grid)) == 0 % non ci sono caselle libere
        out = -1;   % sconfitta
    elseif (grid(1,1) == 2 && grid(1,2) == 2 && grid(1,3) == 2) || ...
            (grid(2,1) == 2 && grid(2,2) == 2 && grid(2,3) == 2) || ...
            (grid(3,1) == 2 && grid(3,2) == 2 && grid(3,3) == 2) || ...
            (grid(1,1) == 2 && grid(2,1) == 2 && grid(3,1) == 2) || ...
            (grid(1,2) == 2 && grid(2,2) == 2 && grid(3,2) == 2) || ...
            (grid(1,3) == 2 && grid(2,3) == 2 && grid(3,3) == 2) || ...
            (grid(1,1) == 2 && grid(2,2) == 2 && grid(3,3) == 2) || ...
            (grid(3,1) == 2 && grid(2,2) == 2 && grid(1,3) == 2)
        
        out = -1;   % sconfitta
    end
end
end

function [ret] = check_zero(matrix)

ret = 0;

[M,N] = size(matrix);
for i = 1:M
    for j = 1:N
        if matrix(i,j) == 0
            ret = ret + 1;
        end
    end
end

end

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

function [id] = board2state(grid)   % da configurazione a valore in base 10

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

function [grid] = state2board(state)    % da stato in base 10 a configurazione

grid = zeros(3,3);

r_ = zeros(1,9);
value = state;
i = 1;
% if value = 0
while value ~= 0
    r = mod (value,3);
    value = (value - r)/3;
    r_(i) = r;
    i = i+1;
end

% grid(1,1) = r_(9);
% grid(1,2) = r_(8);
% grid(1,3) = r_(7);
% grid(2,1) = r_(6);
% grid(2,2) = r_(5);
% grid(2,3) = r_(4);
% grid(3,1) = r_(3);
% grid(3,2) = r_(2);
% grid(3,3) = r_(1);


grid(1,1) = r_(1);
grid(1,2) = r_(2);
grid(1,3) = r_(3);
grid(2,1) = r_(4);
grid(2,2) = r_(5);
grid(2,3) = r_(6);
grid(3,1) = r_(7);
grid(3,2) = r_(8);
grid(3,3) = r_(9);


end

function [prob] = prob_nextState(grid)

n_zero = check_zero(grid);
if n_zero ~= 0
    prob = 1/n_zero;
else
    prob = 0;
end

end


