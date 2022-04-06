close all
clear variables
clc



S_tot = 3^9;
a0 = 9;


% riduzione stati

S = [0:S_tot-1];
num_S = length(S)
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

num_vS = length(vS)

%%  matrice P

%POTREBBE ESSERCI UN ERRORE GIGANTE => RIVEDI DIMENSIONE FIND
P = zeros(num_vS+1, num_vS+1 , a0);

for s = 1:num_vS    % indice stato di partenza s
    
    for a = 1:a0    % scelta dell'azione a
        
        grid = state2board(vS(s));
        grid = azione_value(grid,a,1);
        empty_index = find(transpose(grid) == 0); % questo perché il find cicla per colonne
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
        
        
        prev = grid_(a);
        
        % se sovrascrive
        if (prev == 1 || prev == 2)
            R(s,a) = -1000;
            
            % se libero
        elseif prev == 0
            grid = azione_value(grid,a,1);
            
            ret = win_condition(grid);
            
            % se vince
            if ret == 1
                R(s,a) = 1;
                
                % se perde
            elseif ret == -1
                R(s,a) = -1;
                
                % se il gioco continua
            elseif ret == 0
                R(s,a) = 0;
            end
            
            
            
        end
    end
end

%%

save data.mat P R vS

%%




















