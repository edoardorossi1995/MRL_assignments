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
title('confronto statici - n cicli, eps1 > eps2')
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
title('confronto dinamici - n cicli, eps3 = 10 * eps 4')


%% confronto DINAMICI

k_try_dyn = 2.3;

%dyn = [epsilon, alfa]

dyn1 = [0.3, 0.01];
dyn2 = [0.1, 0.01];

[vittorieDyn1,vittorieDyn2] = compare_dyns(R_store,num_bandit,numero_cicli,numero_test,dyn1(1),dyn1(2),dyn2(1),dyn2(2),k_try_dyn)


figure(54)
pie([vittorieDyn1,vittorieDyn2]);
legend('eps 0.3','eps 0.4')
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


