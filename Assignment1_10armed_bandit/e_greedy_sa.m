function [R_tot, N_t_a, N_t_a_best,y,numazionigreedy] = e_greedy_sa(R_store,n,numero_cicli,epsilon,step,k)


A = (1 : n);   %armed bandit
N_t_a = zeros(1,n);  %contatore esecuzione di ogni azione
Q_a_star = zeros(1,n); %tenderà al valore atteso dei reward
R_tot=0;

j = 0;
y = [];
numazionigreedy = 0;

while j<numero_cicli
    
    % variazione percentuale random sui reward (rumore)
    % N.B. aggiorno e dopo risottraggo delta_R per non variare le formule
    % inserite

    
    ret = rand(1,1);
    
    if ret <= epsilon
        I = randi([1,10],1,1);  %esplorazione random
    else
        [M,I] = max(Q_a_star); % scelta greedy
        epsilon = (epsilon/(step*j+1));
        numazionigreedy = numazionigreedy+1;
    end
    
    R_store(I); %testo l'azione I-esima
    R_tot= R_tot+R_store(I); %aggiorno il reward totale
    N_t_a(I) = N_t_a(I) + 1; %aggiorno il contatore dell'azione I-esima
    alfa = (1/N_t_a(I));
    Q_a_star(I) = Q_a_star(I) + alfa*(R_store(I)-Q_a_star(I));
    j = j+1;
    
    
    
    if isempty(y)
        y = [R_store(I)];
    else
        y = [y; y(end)+ R_store(I)];
    end
    
    R_store = R_store + k*(randi(3,size(R_store))-2);
    
    
    
    
    
end

[M,index] = max(N_t_a);
N_t_a_best = index;

end