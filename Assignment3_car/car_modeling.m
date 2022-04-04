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
    %     j = j+randi([-1 2]);
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
vx_min = -5;
vy_min = -5;
u_bound = [1, n, 1, m];
v_bound = [vx_min, vx_max, vx_min, vy_max];


% definizione indicizzazione di STATO
% s = sub2ind([n m vx_max+1 vy_max+1], ...
%     s_pos(1), s_pos(2), current_vel(1)+1, current_vel(2)+1 );

S = n*m*(abs(vx_max)+abs(vx_min)+1)*(abs(vx_max)+abs(vx_min)+1);

% def azioni

% incrementi unitari di velocità sulle due direzioni N-E, solo aumento

a = [];
for i = 1:9
    [a1,a2] = ind2sub([3 3],i);
    a = [a; [a1-2,a2-2]];
end

A_ = size(a);
A = A_(1);

%     -1    -1
%      0    -1
%      1    -1
%     -1     0
%      0     0
%      1     0
%     -1     1
%      0     1
%      1     1


% [GW.CurrentState, current_vel] = next_state(GW.CurrentState, a(4,:), current_vel)


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


% s0_sl contiene tutti gli stati sulla start line
obs_temp = min(obstacle_states(:,2))
s0_sl = [];

for i = 1:obs_temp-1
    s0_i = sub2ind([15 15 11 11], 15, i, 6,6);
    s0_sl = [s0_sl;s0_i];
end

%% learning

% inizzializzazione parametri
numEpisodes = 2e3;
epsilon = 0.3;
N = zeros(S,A);
Q = zeros(S,A);
%load policy.mat
policy = randi(A,S,1);
gamma = 1;

for e = 1:numEpisodes
    
    
    %s0 = randi(S);
    s0 = s0_sl(randi(length(s0_sl)));
    G = 0;
    
    [s, a, r] = play_episode ...
        (s0, A, policy, epsilon, ...
        obstacle_states,terminal_states, u_bound, v_bound);
    
    for t = length(s)-1: -1: 1
        G = r(t) + gamma*G;
        N(s(t),a(t)) = N(s(t),a(t)) + 1;
        Q(s(t),a(t)) = Q(s(t),a(t)) + 1/N(s(t),a(t))*(G - Q(s(t),a(t)));
        Astar = find(Q(s(t),:) == max(Q(s(t),:)), 1, 'first');
        policy(s(t))  = Astar;
    end
    e
end
%%

save policy.mat policy;

%% esecuzione

start_pos = [n,randi(obs_temp-1)];

% CurrentState rappresenta la POSIZIONE su GW, non lo stato.
% Lo stato è definito da (x,y,vx,vy)
GW.CurrentState =  "[" + num2str(start_pos(1))+"," + num2str(start_pos(2)) + "]";
v_x = 0;
v_y = 0;
R = 0;
isTerminal = false;

while ~isTerminal
    
    pos = str2num(GW.CurrentState());
    x = pos(1);
    y = pos(2);
    s_curr = [x, y, v_x, v_y];
    S_CURR = sub2ind([15 15 11 11], s_curr(1), s_curr(2),s_curr(3)+6,s_curr(4)+6);
    At = policy(S_CURR);
    
    % next_state
    
    % old post
    
    [ax,ay] = ind2sub([3 3],At);
    ax = ax - 2;
    ay = ay - 2;
    
    action = [ax, ay];
    
    % applicazione azione
    
    next_vel_x = v_x + action(1);
    
    next_vel_y = v_y + action(2);
    
    [v_x,v_y] = bound(next_vel_x, next_vel_y,...
        v_bound(1),v_bound(2),v_bound(3),v_bound(4));
    
    next_x = x - v_x;
    
    next_y = y + v_y;
    
    [x,y] = bound(next_x, next_y,...
        u_bound(1),u_bound(2),u_bound(3),u_bound(4));
    
    % parse di stati terminali
    ts = [];
    for i = 1:length(terminal_states(1))
        ts_i = sub2ind([15 15],terminal_states(i,1),terminal_states(i,2));
        ts = [ts; ts_i];
    end
    
    % parse di ostacoli
    os = [];
    for h = 1:length(obstacle_states)
        os_h = sub2ind([15 15],obstacle_states(h,1),obstacle_states(h,2));
        os = [os; os_h];
    end
    
    x
    y
    sub_new_pos = sub2ind([15,15], x, y);
    
    if ~isempty(find((sub_new_pos == ts),1))
        
        % is in terminals
        Rt1 = 0;
        isTerminal = true;
        GW.CurrentState =  "[" + num2str(x)+"," + num2str(y) + "]";
        
    elseif ~isempty(find((sub_new_pos == os), 1))
        
        % is in obstacle
        Rt1 = -1000*15;
        isTerminal = true;
        GW.CurrentState =  "[" + num2str(x)+"," + num2str(y) + "]";
        
    else
        
        % è normale
        Rt1 = -1;
        GW.CurrentState =  "[" + num2str(x)+"," + num2str(y) + "]";
    end
    
    R = R + Rt1;
    
    clf
    plot(env)
    pause(1)
end

%%


