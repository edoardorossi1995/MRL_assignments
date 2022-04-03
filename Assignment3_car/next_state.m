function [sp,r] = next_state(old_pos, current_vel, action, obstacle_states, terminal_states)


next_vel = [min(current_vel(1) + action(1),5), ...
    min(current_vel(2) + action(2),5)];
new_pos = [max(old_pos(1) - next_vel(1),1), ...
    min(old_pos(2) + next_vel(2),15)];
% N.B. 1 e 15 del max dipendono dalla larghezza della mappa

ts = [];
for i = 1:length(terminal_states)
    ts_i = sub2ind([15 15],terminal_states(i,1),terminal_states(i,2));
    ts = [ts; ts_i];
end

os = [];
for h = 1:length(obstacle_states)
    os_h = sub2ind([15 15],obstacle_states(h,1),obstacle_states(h,2));
    os = [os; os_h];
end

sub_new_pos = sub2ind([15,15], new_pos(1), new_pos(2));

if ~isempty(find((sub_new_pos == ts),1)) % is in terminals
    r = 0;
    sp = -1;
elseif ~isempty(find((sub_new_pos == os), 1)) % is in obstacle
    r = -1000*15;
    sp = -2;
else % è normale
    r = -1;
    sp = sub2ind([15,15,6,6], ...
        new_pos(1), new_pos(2), next_vel(1)+1, next_vel(2)+1);
end


end