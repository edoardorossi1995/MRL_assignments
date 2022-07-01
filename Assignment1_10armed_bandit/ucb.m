function [R_tot, N_t_a, N_t_a_best,y] = ucb(R_store,n,numero_cicli,c,alfa,k)

A = (1 : n);   %armed bandit
N_t_a = zeros(1,n);  %contatore esecuzione di ogni azione
Q_a_star = (1:n); %tenderà al valore atteso dei reward
R_tot=0;
I_vect = zeros(1,n);

for i=1:n   %for che inizializza a 0 N_t_a e Q_a_star
    Q_a_star(i) = randi([12,25],1,1); %sperimentale
end

j = 0;
y = [];

while j<numero_cicli
    
    % variazione percentuale random sui reward (rumore)
    % N.B. aggiorno e dopo risottraggo delta_R per non variare le formule
    % inserite

    
    for i=1:n
        I_vect(i) = (Q_a_star(i)+c*sqrt(log(j)/N_t_a(i)));
    end
    
    [M,I] = max(I_vect);
    
    R_store(I); %testo l'azione I-esima
    R_tot= R_tot+R_store(I); %aggiorno il reward totale
    N_t_a(I) = N_t_a(I) + 1; %aggiorno il contatore dell'azione I-esima
    Q_a_star(I) = Q_a_star(I) + alfa*(R_store(I)-Q_a_star(I));
    j = j+1;
    
    %epsilon costante (promemoria)
    
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
