clc
close all
clear variables


n = 15;
m = 15;
GW = createGridWorld(n,m);

numEpisodes = 1e3;
epsilon = 0.5;

% parametro randomico per la posizione iniziale
k = randi([1 10]);

start_state = [n,max(1,10 - k)];
GW.CurrentState =  "[" + num2str(start_state(1))+"," + num2str(start_state(2)) + "]"; % string('[',[n, ',', max(1,10 - k)],']');
numEpisodi = 10;

% creazione stati terminali
h = randi([1 5]);
terminals = [];
for i = 1:h
    terminals = [terminals; string(['[',num2str(i),',15]'])];
end

GW.TerminalStates = terminals;

% creazione ostacoli
comp_i = n-h;
comp_j = k+1;
obstacles = [];
for i = 1:comp_i
    for j = 1:comp_j
        obstacles = [obstacles; string(['[',num2str(n-i+1),',',num2str(m-j+1),']'])];
    end
    j = j+randi([-1 2]);
end
GW.ObstacleStates = obstacles;



env = rlMDPEnv(GW);
env.ResetFcn = @() randi([1 10]);


% def stato corrente
s_pos_str = str2num(GW.CurrentState);
s_pos = [s_pos_str(1),s_pos_str(2)];

current_vel = [0,0];
vx_max = 5;
vy_max = 5;

s = sub2ind([n m vx_max+1 vy_max+1], s_pos(1), s_pos(2), current_vel(1)+1, current_vel(2)+1 );

S = n*m*vx_max*vy_max;

% def azioni

% incrementi unitari sulle due direzioni N-E
a = [[0,0];[1,0];[1,1];[0,1];[-1,0];[-1,1];[-1,-1];[0,-1];[1,-1]];
A = 9;

% [GW.CurrentState, current_vel] = next_state(GW.CurrentState, a(4,:), current_vel)

% al contrario:
% ?

N = zeros(S,A);
Q = zeros(S,A);

%policy = randi(A,S,1);

env = rlMDPEnv(GW)
plot(env)

%%
for e = 1:numEpisodes
    
    s0 = randi(S);  %prendo le S con sub2ind degli stati iniziali
    a0 = randi(A);  %azione casuale
    gamma = 0.6;
    obstacle_states = str2double(GW.ObstacleStates);
    terminal_states = str2double(GW.TerminalStates);
    
    [s, a, r] = play_episode(s0, a0, epsilon,obstacle_states,terminal_states);   %scelta dell'azione epsilon greedy
    G = 0;
    [GW.CurrentState(1),GW.CurrentState(2)] = ind2sub(S,s);
    
    
    e
    
    for t = length(s)-1: -1: 1
        G = r(t) + gamma*G;
        N(s(t),a(t)) = N(s(t),a(t)) + 1;
        Q(s(t),a(t)) = Q(s(t),a(t)) + 1/N(s(t),a(t))*(G - Q(s(t),a(t)));
        Astar = find(Q(s(t),:) == max(Q(s(t),:)), 1, 'first');
        policy  = Astar;
    end
    hold on
    env = rlMDPEnv(GW)
    plot(env)
    
end




%%
env = rlMDPEnv(GW)
plot(env)




