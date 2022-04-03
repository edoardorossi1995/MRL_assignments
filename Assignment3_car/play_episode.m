function [s, a, r] = play_episode(s0, A, policy, epsilon, obstacle_states, terminal_states)

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
        ([15,15,6,6],St);
    
    old_pos = [old_pos_x, old_pos_y];
    
    current_vel_x = current_vel_x - 1;
    current_vel_y = current_vel_y - 1;    
    current_vel = [current_vel_x, current_vel_y];
    
    [ax,ay] = ind2sub([2 2],At);
    ax = ax - 1;
    ay = ay - 1;
    
    
    [St1,Rt1] = next_state ...
        (old_pos, current_vel, [ax,ay], obstacle_states, terminal_states);
        
    
    %St1, Rt1
    s = [s, St1];
    a = [a, At];
    r = [r, Rt1];
    
end