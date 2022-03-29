clc
close all
clear variables


n = 15;
m = 15;
GW = createGridWorld(n,m);


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

[GW.CurrentState, current_vel] = next_state(GW.CurrentState, a(4,:), current_vel)

% al contrario:
% ?

N = zeros(S,A);
Q = zeros(S,A);

policy = randi(A,S,1);

env = rlMDPEnv(GW)
plot(env)

%%




%%
for t = 1:numEpisodi
    
    reset(env)
    isTerminal = false;
    
    s0 = randi(S);
    a0 = randi(S);
    
    %%[s,a,r] = 
    
    while ~isTerminal
        % fai azione eps-greedy => aggiorna current state
        
        epsion = 0.5;
        
        
        reward = -1;
        % se trovo ostacolo
        if ~isempty(find((GW.CurrentState == GW.ObstacleStates), 1))
            
            reward  = -1000*m*n;
            isTerminal = true;
            
        else
            % se sono in uno stato terminale
            if (find((GW.CurrentState == GW.TerminalStates)))
                
                isTerminale = true;
                
            end
        end
    end
end

%%

 for e = 1:numEpisodes
    % S = sub2ind([15 15],start_state(1),start_state(2));
     s0 = randi(S);  %prendo le S con sub2ind degli stati iniziali
     a0 = randi(A);  %azione casuale
     [s ] = next_state(s0, policy, epsilon);   %scelta dell'azione epsilon greedy
     G = 0;
%     for t = length(s)-1: -1: 1
%         G = r(t) + gamma*G;
%         N(s(t),a(t)) = N(s(t),a(t)) + 1;
%         Q(s(t),a(t)) = Q(s(t),a(t)) + 1/N(s(t),a(t))*(G - Q(s(t),a(t)));
%         Astar = find(Q(s(t),:) == max(Q(s(t),:)), 1, 'first');
%         policy(s(t)) = Astar;
%     end
 end
%%
env = rlMDPEnv(GW)
plot(env)

%%




