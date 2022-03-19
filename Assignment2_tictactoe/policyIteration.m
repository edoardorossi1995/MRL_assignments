clear variables
close all
clc

load data.mat

gamma = 0.9;
S = size(P,1); % n stati
A = size(R,2); % n azioni

policy = randi(A,[S,1]); % policy iniziale a caso
value = zeros(S,1); % funz valore iniziale 

oldpolicy = policy;

tic
while true
    value = policyEval(P, R, gamma, policy, value); % valuto la policy corrente
    policy = policyImprovement(P, R, gamma, value);
    if norm(oldpolicy - policy, Inf) == 0 
        break;
    end
    oldpolicy = policy;
end
toc
%%
clc

grid = [0,0,0; 0,0,0; 0,0,0]
id = board2state(grid)
value( id == vS)

%%
s1 = board2state(grid);
grid = Azione(grid, policy(find(vS == s1)))
id = board2state(grid)
value( id == vS)
[num,ind] = check_value(value);
%%
grid = A_oppo(grid,1)
id = board2state(grid)
value( id == vS)
%%
num = check_value(value);
s2 = board2state(grid);
grid = Azione(grid, policy(find(vS == s2)))
id = board2state(grid)
value( id == vS)
%%
grid = A_oppo(grid,7)
s3 = board2state(grid);
num = check_value(value);
id = board2state(grid)
value( id == vS)
%%
num = check_value(value);
s3 = board2state(grid);
grid = Azione(grid, policy(find(vS == s3)))
id = board2state(grid)
value( id == vS)
%%



%% fun

function [num,ind] = check_value(value)
num = [];
ind = [];
for i=1:length(value)
    if value(i) < 0
        num = [num value(i)];
        ind = [ind i];
    end
end

end

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