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