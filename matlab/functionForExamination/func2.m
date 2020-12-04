function [result] = func2(A)
    L = length(A);
    B = sort(A);

    if ceil(L / 2) == (L / 2)
        result = (B(L / 2) + B((L / 2) + 1)) / 2;
    else
        result = B(ceil(L / 2));
    end

end
