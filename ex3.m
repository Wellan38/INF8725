%% Exercice 3

%% Question 1

T = 0:(1/250):0.5-(1/250);

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

% Question 4
% Transformée de Fourier discrète de chaque signal
tf1 = fft(Y1);
tf2 = fft(Y2);
tf3 = fft(Y3);
Fe = 250;
N = size(T,2);
dt=1/Fe;
dF = Fe/N;
f = -Fe/2:dF:Fe/2-dF;
figure(6)
subplot(3,1,1)
plot(f,abs(fftshift(tf1))/N);
xlabel("Frequence (Hz)")
subplot(3,1,2)
plot(f,abs(fftshift(tf2))/N);
xlabel("Frequence (Hz)")
subplot(3,1,3)
plot(f,abs(fftshift(tf3))/N);
xlabel("Frequence (Hz)")
% On remarque que le spectre de chaque signal présente un unique pic en la fréquence directement lisible dans sa formule.
