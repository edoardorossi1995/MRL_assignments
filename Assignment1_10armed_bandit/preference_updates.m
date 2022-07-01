function [R_tot, N_t_a, N_t_a_best,y,H_t,pi_t] = preference_updates(R_store,n,numero_cicli,alfa,k)

A = (1 : n);   %armed bandit
N_t_a = zeros(1,n);  %contatore esecuzione di ogni azione
H_t = zeros(1,n);
R_tot = 0;
pi_t = zeros(1,n);

j = 0;
y = [];

while j<numero_cicli
    
    % variazione percentuale random sui reward (rumore)
    % N.B. aggiorno e dopo risottraggo delta_R per non variare le formule
    % inserite

    
    for i=1:n
        pi_t(i) = exp(H_t(i))/sum(exp(H_t));
    end
    
    p1 = pi_t(1);
    p2 = p1 + pi_t(2);
    p3 = p2 + pi_t(3);
    p4 = p3 + pi_t(4);
    p5 = p4 + pi_t(5);
    p6 = p5 + pi_t(6);
    p7 = p6 + pi_t(7);
    p8 = p7 + pi_t(8);
    p9 = p8 + pi_t(9);
    %p10 = p9 + pi_t(10);
    
    ret = rand(1,1);
    
    if ret <= p1
        I = 1;
    elseif ret <= p2
        I = 2;
    elseif ret <= p3
        I = 3;
    elseif ret <= p4
        I = 4;
    elseif ret <= p5
        I = 5;
    elseif ret <= p6
        I = 6;
    elseif ret <= p7
        I = 7;
    elseif ret <= p8
        I = 8;
    elseif ret <= p9
        I = 9;
    else
        I = 10;
    end
    
    
    A_t = R_store(I);
    N_t_a(I) = N_t_a(I) + 1;
    R_tot = R_tot + R_store(I);
    R_record = R_tot/(j+1);
    
    for i=1:n
        if i == I
            H_t(i) = H_t(i) + alfa*(A_t - R_record) * (1 - pi_t(i));
            
        else
            H_t(i) = H_t(i) + alfa*(A_t - R_record) * (pi_t(i));
        end
    end
    
    j = j+1;
        
    if isempty(y)
        y = [A_t];
    else
        y = [y; y(end)+ R_store(I)];
    end
        
    R_store = R_store + k*(randi(3,size(R_store))-2);

    
end

[M,index] = max(N_t_a);
N_t_a_best = index;
end