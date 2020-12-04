clc
clear
t = 0:0.1:100000;
x = 0:0.1:50;
f1 = 1.55; % Frequency
f2 = 1.53;
k1 = 4.0; % Wave vector
k2 = 3.5;
E1 = 2; % Amplitude
E2 = 2;
w1 = 2 * pi * f1;
w2 = 2 * pi * f2;
figure;
subplot(3, 1, 1)
axis([0, 0.1, -E1 - 1, E1 + 1]);
subplot(3, 1, 2)
axis([0, 0.1, -E2 - 1, E2 + 1]);
subplot(3, 1, 3)
axis([0, 0.1, -E1 - E2 - 2, E1 + E2 + 2]);
tt = 0:5:50;

for k = 1:1:10000000
    y1 = E1 * cos(k1 * x - w1 * t(k));
    y2 = E2 * cos(k2 * x - w2 * t(k));
    y = y1 + y2;
    subplot(3, 1, 1)
    plot(x, y1, 'r');
    set(gca, 'xtick', tt);
    grid on
    ylabel('y1');
    xlabel('x');
    subplot(3, 1, 2)
    plot(x, y2);
    set(gca, 'xtick', tt);
    grid on
    ylabel('y2');
    xlabel('x');
    subplot(3, 1, 3)
    plot(x, y, 'k');
    set(gca, 'xtick', tt);
    grid on
    ylabel('Y');
    xlabel('x');
    M = getframe;
end
