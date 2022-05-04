close all
clear variables
clc



S_tot = 3^9;
a0 = 9;


% riduzione stati

S = (0:S_tot-1);
num_S = length(S);
vS = [];    % valid states


% inserimento dei soli stati con stesso numero di X e O nella griglia
for i=0:(length(S)-1)
    
    grid = state2board(i);
    n1 = check_value(grid,1);   % X
    n2 = check_value(grid,2);   % O
    if n2 == n1
        vS = [vS, i];
    end
    vS;
end

num_vS = length(vS);

%%  matrice P

P = zeros(num_vS+1, num_vS+1 , a0);

for s = 1:num_vS    % indice stato di partenza s
    
    for a = 1:a0    % scelta dell'azione a
        
        grid = state2board(vS(s));
        grid = azione_value(grid,a,1);
        % questo perché il find cicla per colonne
        empty_index = find(transpose(grid) == 0);
        probAS = prob_nextState(grid);
        
        for i=1:length(empty_index)
            grid_ = grid;
            grid_ = azione_value(grid_,empty_index(i),2);
            id = board2state(grid_);
            index_id = find(vS == id);
            P(s,index_id,a) = probAS;
        end
        
    end
    
end


%% matrice R

R = zeros(num_vS+1, a0);

victory_reward = 1;
draw_reward = -1;
lose_reward = -1;
fail_reward = -1000;

% time_penalty_reward = 0;

for s = 1:num_vS    % indice stato di partenza s
    
    for a = 1:a0    % scelta dell'azione a
        
        grid = state2board(vS(s));
        
        
        % converti IL CONTENUTO di grid in vettore 1x9
        cg_ = 1;    % counter grid_
        for i = 1:3
            for k = 1:3
                grid_(cg_) = grid(i,k);
                cg_ = cg_+1;
            end
        end
        
        % check sulla posizione in cui vorrei giocare
        prev = grid_(a);
        
        % se sovrascrive
        if (prev == 1 || prev == 2)
            R(s,a) = fail_reward;
            
            % se libero
        elseif prev == 0
            grid = azione_value(grid,a,1);
            
            ret = win_condition(grid);
            
            
            if ret == 1
                % se vince
                
                R(s,a) = victory_reward;
                
            elseif ret == -1
                
                % se pareggia
                
                R(s,a) = draw_reward;
                
            else
                % se il gioco continua e l'avversario gioca
                % if ret == 0
                
                % il transpose è perché il find funziona a colonne
                empty_index = find(transpose(grid) == 0);
                ei_size = length(empty_index);
                p_lose = 1/ei_size;
                rsa_array =zeros(ei_size,1);
                
                
                for i = 1:ei_size
                    
                    temp_grid = azione_value(grid,empty_index(i),2);
                    
                    temp_ret = win_condition(temp_grid);
                    
                    if temp_ret == -2
                        rsa = lose_reward;
                        
                    else
                        rsa = 0;
                    end
                    rsa_array(i) = rsa;
                    
                end
                % il reward sarà la media
                
                R(s,a) = mean(rsa_array);
                
                
            end
        end
    end
end
%%

save data.mat P R vS

%%