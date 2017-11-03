%% Exercice 4
% Nettoyage
clear all;
clc;
close all;

% pkg load image

%% Question 1
% Chargement de l'image
[img,] = imread('maillot.png');

% TFD
tfd = fftshift(fft2(img));

% Affichage
Lx = size(tfd,1);
Ly = size(tfd,2);
figure;
subplot(1,2,1)
imshow(img)
subplot(1,2,2)
imshow(log(1+abs(tfd/(Lx*Ly)))) % Normalisation et abs

%% Question 2
% Le col correspond aux diagonales excentrées (pics sous les ellipses bleues).
% Le torse correspond a la partie horizontale (puisqu'il presente des rayures verticales) (pics sous la ligne jaune).
% La manche gauche (de face, la manche droite du porteur) correspond a la diagonale des (-+/+-) (pics sous la ligne violette).
% La manche droite correspond a la diagonale (--/++) (pics sous la ligne bleue).
% La poche correspond a la partie verticale (pics sous la ligne rouge).
figure;
imshow('schema.png')
title('Couleurs associées aux pics')

%% Question 3
% Creation du filtre
% 20 semble convenir
H = fspecial('gaussian', size(tfd), 20);
% Application
tfd_passe_bas = (tfd.*H)/(max(max(H)));
% Affichage de l'image transformee
img_passe_bas = uint8(abs(ifft2(ifftshift(tfd_passe_bas))));
figure;
imshow(img_passe_bas);
title('Image filtree (filtre gaussien passe-bas)')

%% Question 4
% On obtient un filtre passe-haut a partir d'un filtre passe-bas.
H_ph = 1 - fspecial('gaussian', size(tfd), 0.5);
% Application
tfd_passe_haut = ((tfd.*H_ph)/(min(min(H_ph))));
% Affichage de l'image transformee
img_passe_haut = uint8(abs(ifft2(ifftshift(tfd_passe_haut))));
figure;
imshow(img_passe_haut);
title('Image filtree (filtre passe-haut)')

%% Question 5
% Creation du filtre
[H_manches,] = imread('filtre_manches.png');
H_manches = double(rgb2gray(H_manches));
% Application
tfd_manches = (tfd.*H_manches)/(15*max(max(H_ph)));
% Affichage
img_manches = uint8(abs(ifft2(ifftshift(tfd_manches))));
figure;
imshow(img_manches);
title('Image filtree (filtre de la question 5)')
% Un petit bout du col reste visible, a cause de la difficulte de supprimer les pics correspondants lorsqu'ils
% sont tres proches de ceux correspondant aux manches.

%% Question 6
% Creation du filtre
[H_non_torse,] = imread('filtre_non_torse.png');
H_non_torse = double(rgb2gray(H_non_torse));
% Application
tfd_sans_torse = (tfd.*H_non_torse)/(max(max(H_non_torse)));
% Affichage
img_sans_torse = uint8(abs(ifft2(ifftshift(tfd_sans_torse))));
figure;
imshow(img_sans_torse);
title('Image filtree (filtre de la question 6');
% Le filtre cree a la main est loin d'etre ideal, mais il est suffisant pour montrer la validite de son principe :
% le filtre precedent masquait tout ce qui n'etait pas les valeurs de la transformee correspondant aux manches et
% son image etait blanche sur ces parties (de façon assez grossiere) ;
% l'image du filtre utilise est noire sur les parties de la representation de la transformee qui correspondent au torse
% et laisse passer toutes les autres valeurs.

%% Question 7
% Un filtre de Butterworth est proche d'un filtre ideal (elimination plus ou moins precise selon l'ordre du filtre de tout ce qui vient apres la coupure ; traitement uniforme des frequences venant avant la coupure) et l'approxime de mieux en mieux au fur et Ã  mesure que l'on augmente son ordre.
% Il ne s'agit cependant pas d'un filtre ideal, seulement d'une tres bonne approximation.

%% Question 8
% La composante continue de l'image est filtree et l'image contient des valeurs negatives/nulles a l'affichage.

%% Question 9
% Il s'agit d'un filtre passe-haut, vu l'ordre d'affichage et les filtres réalisés plus haut.

% ginput();
