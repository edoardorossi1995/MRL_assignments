clc
close all
clear variables

% creazione Gridworld
n = 15;
m = 15;
GW = createGridWorld(n,m);


% parametro randomico per la posizione iniziale
k = randi([1 10]);

start_pos = [n,max(1,10 - k)];

% CurrentState rappresenta la POSIZIONE su GW, non lo stato.
% Lo stato è definito da (x,y,vx,vy)
GW.CurrentState =  "[" + num2str(start_pos(1))+"," + num2str(start_pos(2)) + "]";

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

% convalida dl GW
env = rlMDPEnv(GW);
env.ResetFcn = @() randi([1 10]);


% def posizione corrente
s_pos_str = str2num(GW.CurrentState);
s_pos = [s_pos_str(1),s_pos_str(2)];

% definizione velocità
current_vel = [0,0];
vx_max = 5;
vy_max = 5;

% definizione indicizzazione di STATO
% s = sub2ind([n m vx_max+1 vy_max+1], ...
%     s_pos(1), s_pos(2), current_vel(1)+1, current_vel(2)+1 );

S = n*m*(vx_max+1)*(vy_max+1);

% def azioni

% incrementi unitari di velocità sulle due direzioni N-E, solo aumento
a = [[0,0];[1,0];[0,1];[1,1]]; %[-1,0];[-1,1];[-1,-1];[0,-1];[1,-1]];
A_ = size(a);
A = A_(1);

% [GW.CurrentState, current_vel] = next_state(GW.CurrentState, a(4,:), current_vel)


% inizzializzazione parametri
numEpisodes = 1e2;
epsilon = 0.1;
N = zeros(S,A);
Q = zeros(S,A);
policy = randi(A,S,1);
gamma = 0.6;

env = rlMDPEnv(GW)
plot(env)

obstacle_states = [];
for i = 1:size(GW.ObstacleStates)
o = str2num(GW.ObstacleStates(i));
obstacle_states = [obstacle_states; o];
end

terminal_states = [];
for i = 1:size(GW.TerminalStates)
o = str2num(GW.TerminalStates(i));
terminal_states = [terminal_states; o];
end


%%

for e = 1:numEpisodes
    
    s0 = randi(S);   %prendo le S con sub2ind degli stati iniziali
    %a0 = policy(s0); %randi(A);  %azione casuale
    G = 0;
      
    [s, a, r] = play_episode ...
        (s0, A, policy, epsilon, obstacle_states,terminal_states);
    
    for t = length(s)-1: -1: 1
        G = r(t) + gamma*G;
        N(s(t),a(t)) = N(s(t),a(t)) + 1;
        Q(s(t),a(t)) = Q(s(t),a(t)) + 1/N(s(t),a(t))*(G - Q(s(t),a(t)));
        Astar = find(Q(s(t),:) == max(Q(s(t),:)), 1, 'first');
        policy(s(t))  = Astar;
    end
    
end


%%


