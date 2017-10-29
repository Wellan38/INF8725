%% Exercice 4
% Nettoyage
clear all;
clc;
close all;

pkg load image

%% Question 1
% Chargement de l'image
[img, map] = imread('maillot.png');

% TFD
tfd = fftshift(fft2(img));

% Affichage
imshow(img)
%figure()
%imshow(tfd) % Note : utiliser abs donne une image blanche
%figure()
%plot(abs(tfd))

%% Question 2
% Le col correspond au premier pic.
% Le torse correspond au deuxième.
% La manche gauche (de face, la manche droite du porteur) correspond au troisième pic.
% La manche droite correspond au quatrième.
% La poche correspond au dernier pic.
% TODO: schéma (comment ?)

%% Question 3
% Création du filtre
H = fspecial('gaussian', size(tfd), 25); % 25 semble convenir
% Application
tfd_passe_bas = (tfd.*H)/(max(max(H)));
% Affichage de l'image transformée
img_passe_bas = uint8(abs(ifft2(ifftshift(tfd_passe_bas))));
figure;
imshow(img_passe_bas);
title('Image filtrée (filtre gaussien passe-bas)')

%% Question 4
% On obtient un filtre passe-haut à partir d'un filtre passe-bas.
H_ph = 1 - fspecial('gaussian', size(tfd), 100); % probably not a gaussian
% Application
tfd_passe_haut = (tfd.*H_ph)/(max(max(H)));
% Affichage de l'image transformée
img_passe_haut = uint8(abs(ifft2(ifftshift(tfd_passe_haut))));
figure;
imshow(img_passe_haut);
title('Image filtrée (filtre passe-haut)')

%% Question 5

%% Question 6

%% Question 7
% Un filtre de Butterworth est proche d'un filtre idéal (élimination plus ou moins précise selon l'ordre du filtre de tout ce qui vient après la coupure ; traitement uniforme des fréquences venant avant la coupure) et l'approxime de mieux en mieux au fur et à mesure que l'on augmente son ordre.
% Il ne s'agit cependant pas d'un filtre idéal, seulement d'une très bonne approximation.

%% Question 8

%% Question 9
% La question n'a pas de sens dans le contexte de l'exercice.
% TODO: demander quel est l'ordre pour le maillot.

ginput();
