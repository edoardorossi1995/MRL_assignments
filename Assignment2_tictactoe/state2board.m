function [grid] = state2board(state)    % da stato in base 10 a configurazione

grid = zeros(3,3);

r_ = zeros(1,9);
value = state;
i = 1;
% if value = 0
while value ~= 0
    r = mod (value,3);
    value = (value - r)/3;
    r_(i) = r;
    i = i+1;
end

% grid(1,1) = r_(9);
% grid(1,2) = r_(8);
% grid(1,3) = r_(7);
% grid(2,1) = r_(6);
% grid(2,2) = r_(5);
% grid(2,3) = r_(4);
% grid(3,1) = r_(3);
% grid(3,2) = r_(2);
% grid(3,3) = r_(1);


grid(1,1) = r_(1);
grid(1,2) = r_(2);
grid(1,3) = r_(3);
grid(2,1) = r_(4);
grid(2,2) = r_(5);
grid(2,3) = r_(6);
grid(3,1) = r_(7);
grid(3,2) = r_(8);
grid(3,3) = r_(9);


end