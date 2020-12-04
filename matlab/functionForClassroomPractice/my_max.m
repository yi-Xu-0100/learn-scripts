function maxnumber = my_max(a)
    [m, n] = size(a);
    y = zeros(1, n);

    for i = 1:1:m
        y(i) = max(a(i, :));
    end

    maxnumber = max(y);
end
