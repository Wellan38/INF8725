%% Exercice 4

%% Question 1

[Data, Fe] = audioread('audio.wav');
%audioplayer(Data,Fe);
% Il y a une perturbation sur toute la longueur du morceau, haute frequence.
% Il y a des perturbations ponctuelles basse fr�quence.

%% Question 2

tf = fftshift(fft(Data));
dt = 1/Fe;
N = size(Data,1);
dF = Fe/N;
f = -Fe/2:dF:Fe/2-dF;
figure;
plot(f,abs(tf)/N);
xlabel("Frequence (Hz)");
ylabel("Amplitude");
title("Spectre du signal audio");
% Mi bemol + la bemol(?) + si bemol(?)

%% Question 4

d_lowpass = fdesign.lowpass('N,Fc', 128, 1800/Fe);
%D = fdesign.bandstop('N,Fc1,Fc2', 128, 1000/Fe, 3000/Fe);
Hd_lowpass = design(d_lowpass, 'window');
data_lowpass = filter(Hd_lowpass, Data);
figure;
tf_lowpass = fftshift(fft(data_lowpass));
plot(f,abs(tf_lowpass)/N);
%audiowrite('melodie_lowpass.wav', data_lowpass, Fe);

% Nous avons bien filtr� la perturbation en mi bemol, cependant une grosse
% partie de la m�lodie a �galement disparu (notamment les percussions).
% La solution serait de r�aliser un filtre coupe-bande dont la bande
% bloquante est centr�e sur la perturbation, et suffisamment resser�e pour
% ne pas perdre trop d'information sur la m�lodie.

%% Question 5

hp_filter = fir1(128, 250 / Fe, 'high', chebwin(129, 30));
freqz(hp_filter,1)