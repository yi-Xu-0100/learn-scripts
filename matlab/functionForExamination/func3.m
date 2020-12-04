function [result] = func3(x)

    if x <= -1
        result = x;
    elseif x >= 1
        result = exp(-1 * x + 1);
    else
        result = x^3 * cos(2 * pi * x);
    end

end
