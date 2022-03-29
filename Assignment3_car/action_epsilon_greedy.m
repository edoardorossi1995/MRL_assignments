function [action] = action_epsilon_greedy(actions,epsilon)
    
    ret = rand(1,1);
    
    if ret <= epsilon
        I = randi([1,4],1,1);  %esplorazione random
    else
        [M,I] = max(Q); % scelta greedy
        epsilon = (epsilon/(step*j+1));
        numazionigreedy = numazionigreedy+1;
    end
end