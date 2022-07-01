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