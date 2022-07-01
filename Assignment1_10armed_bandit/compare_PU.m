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