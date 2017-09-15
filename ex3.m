%% Exercice 3

%% Question 1

T = 0:0.0001:2; % domaine temporel

Y1 = 5 * sin(2 * pi * 4 * T); % Y1

Y2 = 3 * sin(2 * pi * 45 * T); % Y2

Y3 = 2 * sin(2 * pi * 70 * T); % Y3

figure('Name','Exercice 3');
subplot(1,2,1);
plot(T, Y1, T, Y2, T, Y3);
title("Differents signaux sinusoidaux");
legend("Y1", "Y2", "Y3");
xlabel("temps (s)");
ylabel("valeur du signal");

%% Question 2

T1 = 0.5 / 2 % periode du signal Y1. Periode théorique = 0.25s

T2 = 0.5 / 22.5 % periode du signal Y2. Periode théorique = 1/45 = 0.222...s

T3 = 0.5 / 35 % periode du signal Y2. Periode théorique = 1/70 = 0.01429...s

%% Question 3

Z = Y1 + Y2 + Y3; % Signal résultant

subplot(1,2,2);
plot(T, Z);
title("Signal résultant");
xlabel("temps (s)");
ylabel("valeur du signal");
grid on;

TZ = 1.561 - 0.5609 % periode empirique du signal

TZ_th = gcd(4, gcd(45, 70)) % periode theorique du signal