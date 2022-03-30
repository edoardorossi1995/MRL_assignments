function [s, a, r] = play_episode(s0, policy, epsilon, obstacle_states, terminal_states)

s = s0;
a = [];
r = [];

while s(end) ~= -1
    St = s(end);
    if rand <= epsilon
        At = randi(9);  %A = 9
    else
        At = policy;
    end
    
    [old_state_x,old_state_y, current_vel_x,current_vel_y] = ind2sub([15,15,6,6],St);
    
    old_state = [old_state_x, old_state_y];
    current_vel = [current_vel_x, current_vel_y];
    
    [ax,ay] = ind2sub([9 2],At);
    
    [St1,Rt1] = next_state(old_state, current_vel, [ax,ay], obstacle_states, terminal_states);
    
    
    %St1, Rt1
    s = [s, St1]
    a = [a, At]
    r = [r, Rt1];
    
end