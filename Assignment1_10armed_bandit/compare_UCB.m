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

