clear variables
close all
clc

load data.mat

gamma = 0.9;

S = size(P,1);
A = size(R,2);

value = randi(A,S,1); % inizializzo la mia funz valore iniziale a caso

prevpolicy = rand(S,1);

tic
while true
    [value, policy] = policyOptim(P, R, gamma, value);
    %disp(norm(policy - prevpolicy))
    if norm(policy - prevpolicy) == 0
        break;
    else
        prevpolicy = policy;
    end
end
toc

%% partenza
clc

grid = [0,0,0; 0,0,0; 0,0,0]
id = board2state(grid)
index_R = find(id == vS)
R(index_R,:)
%% agent - 1
s1 = board2state(grid);
grid = azione_value(grid, policy(find(vS == s1)),1)
id = board2state(grid)
%% oppo - 1
grid = azione_value(grid,2,2)
id = board2state(grid)
index_R = find(id == vS)
R(index_R,:)
%% agent - 2
s2 = board2state(grid);
grid = azione_value(grid, policy(find(vS == s2)),1)
id = board2state(grid)
%% oppo - 2
grid = azione_value(grid,7,2)
s3 = board2state(grid);
id = board2state(grid)
index_R = find(id == vS)
R(index_R,:)


%% agent - 3
s3 = board2state(grid);
grid = azione_value(grid, policy(find(vS == s3)),1)
id = board2state(grid)


%% oppo - 3
grid = azione_value(grid,9,2)
s4 = board2state(grid);
id = board2state(grid)
index_R = find(id == vS)
R(index_R,:)


