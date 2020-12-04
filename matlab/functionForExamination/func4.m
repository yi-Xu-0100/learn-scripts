function [] = func4()
    x = linspace(-8 * pi, 8 * pi, 400);
    y1 = sin(2 * x);
    y2 = cos(2 * x);
    figure(1)
    plot(x, y1, 'r-', x, y2, 'g--');
    title('y1&y2');
    figure(2)
    subplot(2, 1, 1);
    plot(x, y1, 'r-');
    title('y1');
    subplot(2, 1, 2);
    plot(x, y2, 'g--');
    title('y2');
end
