%% Exercice 3

% Question 1

T = 0:0.0001:0.5; % domaine temporel

Y1 = 5 * sin(2 * pi * 4 * T); % Y1

Y2 = 3 * sin(2 * pi * 45 * T); % Y2

Y3 = 2 * sin(2 * pi * 70 * T); % Y3

plot(T, Y1, T, Y2, T, Y3);
title("Différents signaux sinusoïdaux");
legend("Y1", "Y2", "Y3");
xlabel("temps (s)");
ylabel("valeur du signal");

% Question 2

T1 = 0.5 / 2 % période du signal Y1. Période théorique = 0.25s

T2 = 0.5 / 22.5 % période du signal Y2. Période théorique = 1/45 = 0.222...s

T3 = 0.5 / 35 % période du signal Y2. Période théorique = 1/45 = 0.01429...s

