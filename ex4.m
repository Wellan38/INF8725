%%
% Exercice 4

% Question 1
[Data, Fe] = audioread('audio.wav');
%audioplayer(Data,Fe);
% Il y a une perturbation sur toute la longueur du morceau, haute frÃ©quence.
% Il y a des perturbations ponctuelles basse fréquence.

% Question 2
tf = fftshift(fft(Data));
dt = 1/Fe;
N = size(Data,1);
dF = Fe/N;
f = -Fe/2:dF:Fe/2-dF;
figure;
plot(f,abs(tf)/N);
xlabel("Fréquence (Hz)");
ylabel("Amplitude");
title("Spectre du signal audio");
% Mi bemol + la bemol(?) + si bemol(?)
