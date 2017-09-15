%% Exercice 3 : Analyse spectrale

%% Question 1

%%
% D�finition du domaine temporel :
T = 0:(1/250):0.5-(1/250);

%%
% D�finition des signaux �l�mentaires :

% Y1
Y1 = 5 * sin(2 * pi * 4 * T);

% Y2
Y2 = 3 * sin(2 * pi * 45 * T);

% Y3
Y3 = 2 * sin(2 * pi * 70 * T);

%%
% Affichage des signaux �l�mentaires :
figure;
subplot(1,2,1);
plot(T, Y1, T, Y2, T, Y3);
title("Signaux �l�mentaires");
legend("Y1", "Y2", "Y3");
xlabel("temps (s)");
ylabel("valeur du signal");

%% Question 2

%%
% P�riode du signal Y1. P�riode th�orique = 0.25s :
T1 = 0.5 / 2

%%
% P�riode du signal Y2. P�riode th�orique = 1/45 = 0.222...s :
T2 = 0.5 / 22.5

%%
% P�riode du signal Y2. P�riode th�orique = 1/70 = 0.01429...s :
T3 = 0.5 / 35

%% Question 3

%%
% D�finition du signal r�sultant :
Z = Y1 + Y2 + Y3;

%%
% Affichage du signal r�sultant :
subplot(1,2,2);
plot(T, Z);
title("Signal r�sultant");
xlabel("temps (s)");
ylabel("valeur du signal");
grid on;

%%
% P�riode empirique du signal :
TZ = 1.561 - 0.5609

%%
% P�riode th�orique du signal :
TZ_th = gcd(4, gcd(45, 70))

%% Question 4
% Transform�e de Fourier discr�te de chaque signal
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
% On remarque que le spectre de chaque signal pr�sente un unique pic en la fr�quence directement lisible dans sa formule.

% Question 5
% Transformee de Fourier discrete du signal composite
tf = fft(Y1 + Y2 + Y3);
figure(7)
plot(f,abs(fftshift(tf))/N);
xlabel("Frequence (Hz)")
% On constate que le spectre du signal composite est compos� des fr�quences de chaque signal pr�sent dans la somme.
