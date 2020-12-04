function [result] = func5(n)
    func(1) = 1;
    func(2) = 0;
    func(3) = 1;

    if n > 3
        func(n) = func5(n - 1) + 2 * func5(n - 2) + func5(n - 3);
    end

    result = func(n);
end
