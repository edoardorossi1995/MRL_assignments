%%  MRL - ASSIGNMENT 1: 10-ARMS

clc
close all
clear variables

%  design problem 10-arm


num_bandit = 10; % numero armed bandit (n azioni)
numero_cicli = 1e4;
numero_test = 0.5*1e2;
R_store = randi([0 10],1,num_bandit) % randomizzazione dei Reward se eseguo qui -> AMBIENTE STATICO
[max,ind] = max(R_store);
R_best = ind  % reward migliore (da comparare con futura scelta migliore)



%%  epsilon greedy sample average (static)

% la variazione dell'epsilon è dentro l'if, in modo tale che l'epsilon
% diminuisce solo quando il sistema NON esplora. Se il sistema esplora, ciò
% non contribuisce a diminiuire epsilon.

k = 2;
step1 = 0.0001;
step2 = 0.0001;
epsilon1 = 0.2;
epsilon2 = 0.1;

[R_totale1,Nta1,my_Nta1,y1,jaka1] = e_greedy_sa(R_store,num_bandit,numero_cicli,epsilon1,step1,k);
R_totale1
Nta1
my_Nta1
jaka1
[R_totale2,Nta2,my_Nta2,y2,jaka2] = e_greedy_sa(R_store,num_bandit,numero_cicli,epsilon2,step2,k);
R_totale2
Nta2
my_Nta2
jaka2


figure(1)
grid on
x = 1:numero_cicli;
hold on
plot(x,y1)
plot(x,y2)
title('confronto statici - n_cicli')
legend('f1','f2')


%%  epsilon greedy sample average (dynamic)

k_dyn = 2;

epsilon3 = 0.1;
alfa3 = 1;

epsilon4 = 0.01;
alfa4 = 1;

[R_totale3,Nta3,my_Nta3,y3] = e_greedy_dyn_sa(R_store,num_bandit,numero_cicli,epsilon3,alfa3,k_dyn);
R_totale3
Nta3
my_Nta3
[R_totale4,Nta4,my_Nta4,y4] = e_greedy_dyn_sa(R_store,num_bandit,numero_cicli,epsilon4,alfa4,k_dyn);
R_totale4
Nta4
my_Nta4


figure(2)
grid on
x = 1:numero_cicli;
hold on
plot(x,y3)
plot(x,y4)
legend('f3','f4')
title('confronto dinamici - n_cicli')


%% confronto DINAMICI

k_try_dyn = 2.3;

%dyn = [epsilon, alfa]

dyn1 = [0.3, 0.01]
dyn2 = [0.4, 0.01]

[vittorieDyn1,vittorieDyn2] = compare_dyns(R_store,num_bandit,numero_cicli,numero_test,dyn1(1),dyn1(2),dyn2(1),dyn2(2),k_try_dyn)


figure(54)
pie([vittorieDyn1,vittorieDyn2]);
legend('dyn','dyn2')
title('confronto dinamici - m prove da n cicli')

% dyn_def = [epsilon, alfa, k]
% dyn_def = [0.4, 0.01, 2.3];
% 0.3 e 0.4 danno valori simili. con rumore alto, scegliamo 0.4



%% confronto STATICO/DINAMICO (2)

k = 2;

% lo step_st rende meglio intorno a valori come 0.1, che tanto poi diverge
% a rumore nullo, non ho trovato alfa (a parità di epsilon) che vince lo
% step statico

% vettore di soluzioni [epsilon ,step] ottimale per k = 0
statico_def = [0.1, 0.0001];
dyn_def = [0.4, 0.01, 2.3];

[vittorieStatico,vittorieDinamico] = compare_st_dyn(R_store, num_bandit,numero_cicli,numero_test,statico_def(1),dyn_def(1),statico_def(2),dyn_def(2),k)


figure(52)
pie([vittorieStatico,vittorieDinamico]);
legend('stat','dyn')
title('confronto statico dinamico - m prove da n cicli')

%%  Upper Confidence Bound

k_dyn = 3;
alfa5 = 0.3;
alfa6 = 0.4;
c5 = 3;
c6 = 5;

[R_totale5,Nta5,my_Nta5,y5] = ucb(R_store,num_bandit,numero_cicli,c5,alfa5,k_dyn);
R_totale5
Nta5
my_Nta5

[R_totale6,Nta6,my_Nta6,y6] = ucb(R_store,num_bandit,numero_cicli,c6,alfa6,k_dyn);
R_totale6
Nta6
my_Nta6

figure(3)
grid on
x = 1:numero_cicli;
hold on
plot(x,y5)
plot(x,y6)
legend('f5','f6')
title('confronto ucb - n cicli')


% a parità di alfa, i valori migliori di c sono tra 3 e 4.
%% compare UCB
k = 2.3;

ucb1 = [3,0.01]
ucb2 = [4,0.01]

[vittorieUCB1,vittorieUCB2] = compare_UCB(R_store, num_bandit, numero_cicli,numero_test,ucb1(1),ucb1(2),ucb2(1),ucb2(2),k)

figure(56)
pie([vittorieUCB1,vittorieUCB2]);
legend('ucb1','ucb2')
title('confronto ucb - m prove da n cicli')

%ucb_def = [c,alfa,k]
ucb_def = [3,0.01,2.3];
%%  preference updates

k_dyn = 1;
alfa7 = 0.2;
alfa8 = 0.2;


[R_totale7,Nta7,my_Nta7,y7,H_t7,pi_t7] = preference_updates(R_store,num_bandit,numero_cicli,alfa7,k_dyn);
R_totale7
Nta7
my_Nta7
H_t7
pi_t7


[R_totale8,Nta8,my_Nta8,y8,H_t8,pi_t8] = preference_updates(R_store,num_bandit,numero_cicli,alfa8,k_dyn);
R_totale8
Nta8
my_Nta8
H_t8
pi_t8

figure(4)
grid on
x = 1:numero_cicli;
hold on
plot(x,y7)
plot(x,y8)
legend('7','8')
title('confronto pu - n cicli')

%% compare preference updates

k = 2.3;
alfa1 = 0.01
alfa2 = 0.005

[vittoriePU1,vittoriePU2] = compare_PU(R_store, num_bandit, numero_cicli, numero_test, alfa1,alfa2,k)

figure(57)
pie([vittoriePU1,vittoriePU2]);
legend('pu1','pu2')
title('confronto pu - m prove da n cicli')

alfapu_def = 0.01;

%% best function
x = 1:numero_cicli;
k_noise = 50;

% variabili statico
statico_def = [0.1, 0.0001];

% variabili dinamico
dyn_def=[0.4, 0.01, 2.3];

% variabili UCB
ucb_def = [3,0.01,2.3];

% variabili PU
alfapu_def = 0.01;



[R_totale_best_static,Nta_best_static,my_Nta_best_static,y_best_static,jaka_best] = e_greedy_sa(R_store,num_bandit,numero_cicli,statico_def(1),statico_def(2),k_noise);
[R_totale_best_dyn,Nta_best_dyn,my_Nta_best_dyn,y_best_dyn] = e_greedy_dyn_sa(R_store,num_bandit,numero_cicli,dyn_def(1),dyn_def(2),k_noise);
[R_totale_best_ucb,Nta_best_ucb,my_Nta_best_ucb,y_best_ucb] = ucb(R_store,num_bandit,numero_cicli,ucb_def(1),ucb_def(2),k_noise);
[R_totale_best_pu,Nta_best_pu,my_Nta_best_pu,y_best_pu,H_t_best_pu,pi_t_best_pu] = preference_updates(R_store,num_bandit,numero_cicli,alfapu_def,k_noise);


figure(10)
hold on

plot(x,y_best_static)
plot(x,y_best_dyn)
plot(x,y_best_ucb)
plot(x,y_best_pu)

grid on
legend('static','dyn','UCB','PU')
title('confronto totale dei reward - n cicli')



%% test compare totale

x = 1:numero_cicli;
k = 3;

% variabili statico
statico_def = [0.1, 0.0001];

% variabili dinamico
dyn_def=[0.4, 0.01, 2.3];

% variabili UCB
ucb_def = [3,0.01,2.3];

% variabili PU
alfapu_def = 0.01;

[vittorieStatico,vittorieDyn,vittorieUCB,vittoriePU] = compare_totale(R_store,num_bandit,numero_cicli,numero_test,statico_def(1),statico_def(2),dyn_def(1),dyn_def(2),ucb_def(1),ucb_def(2),alfapu_def,k)


% figure(15)
% legend('statico','dinamico','ucb','pu')
% pie3([vittorieStatico,vittorieDyn,vittorieUCB,vittoriePU]);

%%  prove per grafico

v = [vittorieStatico,vittorieDyn,vittorieUCB,vittoriePU]
figure(97)
pie(v)
title('confronto totale reward - m prove da n cicli')
legend('statico','dinamico','ucb','pu')


%% functions
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
function [R_tot, N_t_a, N_t_a_best,y] = e_greedy_dyn_sa(R_store,n,numero_cicli,epsilon,alfa,k)

A = (1 : n);   %armed bandit
N_t_a = zeros(1,n);  %contatore esecuzione di ogni azione
Q_a_star = zeros(1,n); %tenderà al valore atteso dei reward
R_tot=0;

j = 0;
y = [];

while j<numero_cicli
    
    % variazione percentuale random sui reward (rumore)
    % N.B. aggiorno e dopo risottraggo delta_R per non variare le formule
    % inserite

    
    if rand(1,1) <= epsilon
        I = randi([1,10],1,1);  %esplorazione random
    else
        [M,I] = max(Q_a_star); % scelta greedy
    end
    
    
    R_store(I); %testo l'azione I-esima
    R_tot= R_tot+R_store(I); %aggiorno il reward totale
    N_t_a(I) = N_t_a(I) + 1; %aggiorno il contatore dell'azione I-esima
    Q_a_star(I) = Q_a_star(I) + alfa*(R_store(I)-Q_a_star(I));
    j = j+1;
    
    %epsilon costante (promemoria)
    
    if length(y) == 0
        y = [R_store(I)];
    else
        y = [y; y(end)+ R_store(I)];
    end
    
    R_store = R_store + k*(randi(3,size(R_store))-2);

    
    
end

[M,index] = max(N_t_a);
N_t_a_best = index;

end
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
function [vittorieStatico,vittorieDinamico] = compare_st_dyn(R_store, num_bandit,numero_cicli,numero_test,epsilon_st,epsilon_dyn,step_st,alfa_dyn,k)
v_st = 0;
v_dyn = 0;

j = 0;

while j<numero_test
    
    [R_totaleST,NtaST,my_NtaST,yST,jakaST] = e_greedy_sa(R_store,num_bandit,numero_cicli,epsilon_st,step_st,k);
    [R_totaleDN,NtaDN,my_NtaDN,yDN] = e_greedy_dyn_sa(R_store,num_bandit,numero_cicli,epsilon_dyn,alfa_dyn,k);
    
    if (R_totaleST > R_totaleDN)
        v_st = v_st + 1;
    else
        v_dyn = v_dyn + 1;
    end
    
    j = j+1;
    
end

vittorieStatico = v_st/numero_test;
vittorieDinamico = v_dyn/numero_test;



end
function [vittorieDyn1,vittorieDyn2,tieT] = compare_dyns(R_store, num_bandit,numero_cicli,numero_test,epsilon_dyn1,alfa1,epsilon_dyn2,alfa2,k)
v_dyn1 = 0;
v_dyn2 = 0;
tie = 0;

j = 0;

while j<numero_test %N.B. esce una quantità enorme di test
    
    [R_totaleDN1,NtaDN1,my_NtaDN1,yDN1] = e_greedy_dyn_sa(R_store,num_bandit,numero_cicli,epsilon_dyn1,alfa1,k);
    [R_totaleDN2,NtaDN2,my_NtaDN2,yDN2] = e_greedy_dyn_sa(R_store,num_bandit,numero_cicli,epsilon_dyn2,alfa2,k);
    
    if (R_totaleDN1 > R_totaleDN2)
        v_dyn1 = v_dyn1 + 1;
    elseif R_totaleDN1 == R_totaleDN2
        tie = tie+1;
    else
        v_dyn2 = v_dyn2 + 1;
    end
    
    j = j+1;
    
end

vittorieDyn1 = v_dyn1/numero_test;
vittorieDyn2 = v_dyn2/numero_test;
tieT = tie/numero_test;



end
function [vittorieUCB1,vittorieUCB2] = compare_UCB(R_store, num_bandit, numero_cicli,numero_test,c1,alfa1,c2,alfa2,k)
v_ucb1 = 0;
v_ucb2 = 0;

j = 0;

while j<numero_test
    
    [R_totaleUCB1,NtaUCB1,my_NtaUCB1,yUCB1] = ucb(R_store,num_bandit,numero_cicli,c1,alfa1,k);
    [R_totaleUCB2,NtaUCB2,my_NtaUCB2,yUCB2] = ucb(R_store,num_bandit,numero_cicli,c2,alfa2,k);
    
    if (R_totaleUCB1 > R_totaleUCB2)
        v_ucb1 = v_ucb1 + 1;
    else
        v_ucb2 = v_ucb2 + 1;
    end
    
    j = j+1;
    
end

vittorieUCB1 = v_ucb1/numero_test;
vittorieUCB2 = v_ucb2/numero_test;

end
function [vittoriePU1,vittoriePU2] = compare_PU(R_store, num_bandit, numero_cicli, numero_test, alfa1,alfa2,k)
v_pu1 = 0;
v_pu2 = 0;

j = 0;

while j<numero_test
    
    [R_totalePU1,NtaPU1,my_NtaPU1,yPU1] = preference_updates(R_store,num_bandit,numero_cicli,alfa1,k);
    [R_totalePU2,NtaPU2,my_NtaPU2,yPU2] = preference_updates(R_store,num_bandit,numero_cicli,alfa2,k);
    
    if (R_totalePU1 > R_totalePU2)
        v_pu1 = v_pu1 + 1;
    else
        v_pu2 = v_pu2 + 1;
    end
    
    j = j+1;
    
end

vittoriePU1 = v_pu1/numero_test;
vittoriePU2 = v_pu2/numero_test;
end
function [vittorieStatico,vittorieDyn,vittorieUCB,vittoriePU] = compare_totale(R_store,num_bandit,numero_cicli,numero_test,epsilon_statico,step_statico,epsilon_dyn,alfa_dyn,c,alfa_ucb,alfa_pu,k)

vittorie = [0,0,0,0];

j = 0;

while j < numero_test
    
    [R_totaleST,NtaST,my_NtaST,yST,jakaST] = e_greedy_sa(R_store,num_bandit,numero_cicli,epsilon_statico,step_statico,k);
    [R_totaleDN,NtaDN,my_NtaDN,yDN] = e_greedy_dyn_sa(R_store,num_bandit,numero_cicli,epsilon_dyn,alfa_dyn,k);
    [R_totaleUCB,NtaUCB,my_NtaUCB,yUCB] = ucb(R_store,num_bandit,numero_cicli,c,alfa_ucb,k);
    [R_totalePU,NtaPU,my_NtaPU,yPU] = preference_updates(R_store,num_bandit,numero_cicli,alfa_pu,k);
    
    test = [R_totaleST,R_totaleDN,R_totaleUCB,R_totalePU];
    [M,ind] = max(test);
    
    vittorie(ind) = vittorie(ind)+1;
    
    j = j+1;
end

vittorieStatico = vittorie(1)/numero_test;
vittorieDyn = vittorie(2)/numero_test;
vittorieUCB = vittorie(3)/numero_test;
vittoriePU = vittorie(4)/numero_test;

figure(98)
pie(vittorie)
title('compare best wins')
legend('statico','dinamico','ucb','pu')

end