%% Exercice 4
% Nettoyage
clear all;
clc;
close all;

%pkg load image

%% Question 1
% Chargement de l'image
[img,] = imread('maillot.png');

% TFD
tfd = fftshift(fft2(img));

% Affichage
Lx = size(tfd,1);
Ly = size(tfd,2);
imshow(img)
figure()
imshow(log(1+abs(tfd/(Lx*Ly)))) % Normalisation et abs

%% Question 2
% Le col correspond au centre.
% Le torse correspond à la partie horizontale (puisqu'il présente des rayures verticales).
% La manche gauche (de face, la manche droite du porteur) correspond à la diagonale des (-+/+-).
% La manche droite correspond à la diagonale (--/++).
% La poche correspond à la partie verticale.
% TODO: schema


%% Question 3
% Création du filtre
H = fspecial('gaussian', size(tfd), 20); % 20 semble convenir
% Application
tfd_passe_bas = (tfd.*H)/(max(max(H)));
% Affichage de l'image transformée
img_passe_bas = uint8(abs(ifft2(ifftshift(tfd_passe_bas))));
figure;
imshow(img_passe_bas);
title('Image filtrÃ©e (filtre gaussien passe-bas)')

%% Question 4
% On obtient un filtre passe-haut à partir d'un filtre passe-bas.
H_ph = 1 - fspecial('gaussian', size(tfd), 0.5);
% Application
tfd_passe_haut = ((tfd.*H_ph)/(min(min(H_ph))));
% Affichage de l'image transformée
img_passe_haut = uint8(abs(ifft2(ifftshift(tfd_passe_haut))));
figure;
imshow(img_passe_haut);
title('Image filtrée (filtre passe-haut)')

%% Question 5
% Creation du filtre
H_manches = load('filtre_ph_test.png');
H_manches = rgb2gray(H_manches);
H_manches = double([[H_manches ones(548,4)];ones(3,777)]);
% Application

% Affichage
%% Question 6

%% Question 7
% Un filtre de Butterworth est proche d'un filtre idéal (Ã©limination plus ou moins prÃ©cise selon l'ordre du filtre de tout ce qui vient aprÃ¨s la coupure ; traitement uniforme des frÃ©quences venant avant la coupure) et l'approxime de mieux en mieux au fur et Ã  mesure que l'on augmente son ordre.
% Il ne s'agit cependant pas d'un filtre idéal, seulement d'une très bonne approximation.

%% Question 8
% La composante continue de l'image est filtrée et l'image contient des valeurs négatives/nulles à l'affichage.

%% Question 9
% La question n'a pas de sens dans le contexte de l'exercice.
% TODO: demander quel est l'ordre pour le maillot.

%ginput();
