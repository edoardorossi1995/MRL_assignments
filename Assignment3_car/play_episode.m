function [s, a, r] = play_episode(s0, A, policy, epsilon, obstacle_states, terminal_states, u_bound, v_bound)

s = s0;
a = [];
r = [];

while (s(end) ~= -1 && s(end) ~= -2)
    
    % scelta azione At
    St = s(end);
    if rand <= epsilon
        At = randi(A);
    else
        At = policy(s(end));
    end
    
    % preparo le variabili old_pos, current_vel per next_state()
    [old_pos_x,old_pos_y, current_vel_x,current_vel_y] = ind2sub ...
        ([15,15,11,11],St);
    
    old_pos = [old_pos_x, old_pos_y];
    
    current_vel_x = current_vel_x - 6;
    current_vel_y = current_vel_y - 6;
    current_vel = [current_vel_x, current_vel_y];
    
    [ax,ay] = ind2sub([3 3],At);
    ax = ax - 2;
    ay = ay - 2;
    
    action = [ax, ay];
    
    
    % inizia NEXT_STATE
    
    next_vel_x = current_vel(1) + action(1);

    next_vel_y = current_vel(2) + action(2);

    [next_vel_x,next_vel_y] = bound(next_vel_x, next_vel_y,...
        v_bound(1),v_bound(2),v_bound(3),v_bound(4));
    
    next_vel = [next_vel_x,next_vel_y];
    
    next_x = old_pos(1) - next_vel(1);

    next_y = old_pos(2) + next_vel(2);

    [next_x,next_y] = bound(next_x, next_y,...
        u_bound(1),u_bound(2),u_bound(3),u_bound(4));
    
    new_pos = [next_x,next_y];
    
    
    % confronto lo stato attuale agli stati terminali del percorso
    
    ts = [];
    for i = 1:length(terminal_states(1))
        ts_i = sub2ind([15 15],terminal_states(i,1),terminal_states(i,2));
        ts = [ts; ts_i];
    end
    
    os = [];
    for h = 1:length(obstacle_states)
        os_h = sub2ind([15 15],obstacle_states(h,1),obstacle_states(h,2));
        os = [os; os_h];
    end
    
    
    sub_new_pos = sub2ind([15,15], new_pos(1), new_pos(2));
    
    if ~isempty(find((sub_new_pos == ts),1))
        
        % is in terminals
        Rt1 = 0;
        St1 = -1;
    elseif ~isempty(find((sub_new_pos == os), 1))
        
        % is in obstacle
        Rt1 = -1000*15;
        St1 = -2;
    else
        
        % è normale
        Rt1 = -1;
        St1 = sub2ind([15,15,11,11], ...
            new_pos(1), new_pos(2), next_vel(1)+6, next_vel(2)+6);
    end
    
    
    % St1, Rt1
    s = [s, St1];
    a = [a, At];
    r = [r, Rt1];
    
end
end