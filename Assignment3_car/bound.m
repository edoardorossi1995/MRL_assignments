function [value_x, value_y] = bound(value_x,value_y,min_x,max_x,min_y,max_y)

if value_x < min_x
    value_x = min_x;
elseif value_x > max_x
    value_x = max_x;
end
if value_y < min_y
    value_y = min_y;
elseif value_y > max_y
    value_y = max_y;
end