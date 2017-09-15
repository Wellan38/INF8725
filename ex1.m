%% Exercice 1

% Question 1

X = 0:pi/13:7*pi; % domaine

Y = sin(X); % fonction sinus

C = 2.8 * ones(size(X)); % fonction constante à 2.8

B = sqrt(0.4) .* randn(size(X)) + 0.1; % bruit gaussien de moyenne 0.1 et de variance 0.4

Z = Y + C + B; % somme des signaux

meanZ = mean(Z) % moyenne de Z

varZ = var(Z) % variance de Z

% Question 2

plot(X, Y, X, C, X, B, X, Z);
title("Sinus, constante, bruit et signal résultant");
grid on;
xlim([0 7*pi]);
legend("Y", "C", "B", "Z");