function [sp,r] = next_state(old_state, current_vel, action, obstacle_states, terminal_states)



next_vel = [min(current_vel(1) + action(1),5), min(current_vel(2) + action(2),5)];
new_state = [max(old_state(1) - next_vel(1),1), min(old_state(2) + next_vel(2),15)]; % N.B. 1 e 15 del max dipendono dalla larghezza della mappa

if ~isempty(find((new_state == terminal_states),1)) % is in terminals
    r = 0;
    sp = -1;
elseif ~isempty(find((new_state == obstacle_states), 1)) % is in obstacle
    r = -1000*15;
    sp = -1;
else % è normale
    r = -1;
    sp = sub2ind([15,15,6,6],new_state(1), new_state(2), next_vel(1)+1, next_vel(2)+1);
end


end