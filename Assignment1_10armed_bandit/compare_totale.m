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