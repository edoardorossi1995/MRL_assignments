clear variables
close all
clc

load data.mat

gamma = 0.99;
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
value( find(id == vS),1)

%% azione giocatore
s1 = board2state(grid);
grid = azione_value(grid, policy(find(vS == s1)),1)
id = board2state(grid)
value( find(id == vS),1)
[num,ind] = check_value_diqua(value);
%% azione oppo
grid = azione_value(grid,1,2)
id = board2state(grid)
value( find(id == vS),1)
%% azione giocatore
num = check_value_diqua(value);
s2 = board2state(grid);
grid = azione_value(grid, policy(find(vS == s2)),1)
id = board2state(grid)
value( find(id == vS),1)
%% azione oppo
grid = azione_value(grid,7,2)
s3 = board2state(grid);
num = check_value_diqua(value);
id = board2state(grid)
value( find(id == vS),1)
%%
num = check_value_diqua(value);
s3 = board2state(grid);
grid = azione_value(grid, policy(find(vS == s3)),1)
id = board2state(grid)
value( find(id == vS),1)
%% azione oppo
grid = azione_value(grid,4,2)
s3 = board2state(grid);
num = check_value_diqua(value);
id = board2state(grid)
value( find(id == vS),1)



%% fun

function [num,ind] = check_value_diqua(value)
num = [];
ind = [];
for i=1:length(value)
    if value(i) < 0
        num = [num value(i)];
        ind = [ind i];
    end
end

end
