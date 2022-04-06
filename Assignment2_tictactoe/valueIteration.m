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

%%
clc

grid = [0,0,0; 0,0,0; 0,0,0]
id = board2state(grid)
value( id == vS)

%%
s1 = board2state(grid);
grid = azione_value(grid, policy(find(vS == s1)),1)
id = board2state(grid)
value( id == vS)
[num,ind] = check_value(value);
%%
grid = azione_value(grid,1,2)
id = board2state(grid)
value( id == vS)
%%
num = check_value(value);
s2 = board2state(grid);
grid = azione_value(grid, policy(find(vS == s2)),1)
id = board2state(grid)
value( id == vS)
%%
grid = azione_value(grid,7,2)
s3 = board2state(grid);
num = check_value(value);
id = board2state(grid)
value( id == vS)
%%
num = check_value(value);
s3 = board2state(grid);
grid = azione_value(grid, policy(find(vS == s3)),1)
id = board2state(grid)
value( id == vS)


%% fun

function [num] = check_value(value)
num = 0;
for i=1:length(value)
    if value(i) < 0
        num = num +1;
    end
end

end
