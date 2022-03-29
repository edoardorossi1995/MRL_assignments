function [new_state,next_vel] = next_state(old_state, action, current_vel)

next_vel = [min(current_vel(1) + action(1),5), min(current_vel(2) + action(2),5)];
real_old_state = str2num(old_state); % non stringa
real_new_state = [max(real_old_state(1) - next_vel(1),1), min(real_old_state(2) + next_vel(2),15)]; % N.B. 1 e 15 del max dipendono dalla larghezza della mappa
new_state = "[" + num2str(real_new_state(1))+"," + num2str(max(1,real_new_state(2))) + "]";

end