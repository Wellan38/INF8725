%% Exercice 4

%%
% Nettoyage
clear all;
clc;
close all;

%% Question 1

%%
% Chargement de l'image
[img,] = imread('maillot.png');

%%
% TFD
tfd = fftshift(fft2(img));

%%
% Affichage
Lx = size(tfd,1);
Ly = size(tfd,2);
figure;
subplot(1,2,1)
imshow(img)
title('Maillot.png')
subplot(1,2,2)
imshow(log(1+abs(tfd/(Lx*Ly))))
title('TFD de l''image Maillot.png')

%% Question 2

%%
% Le col correspond aux diagonales excentr�es (pics sous les ellipses bleues).
% Le torse correspond a la partie horizontale (puisqu'il presente des rayures verticales) (pics sous la ligne jaune).
% La manche gauche (de face, la manche droite du porteur) correspond a la diagonale des (-+/+-) (pics sous la ligne violette).
% La manche droite correspond a la diagonale (--/++) (pics sous la ligne bleue).
% La poche correspond a la partie verticale (pics sous la ligne rouge).
figure;
imshow('schema.png')
title('Couleurs associ�es aux pics')

%% Question 3

%%
% Cr�ation du filtre ; sigma = 20 semble convenir.
H = fspecial('gaussian', size(tfd), 20);

%%
% Application
tfd_passe_bas = (tfd.*H)/(max(max(H)));

%%
% Affichage de l'image transform�e
img_passe_bas = uint8(abs(ifft2(ifftshift(tfd_passe_bas))));
figure;
imshow(img_passe_bas);
title('Image filtr�e (filtre gaussien passe-bas)')

%% Question 4

%%
% On obtient un filtre passe-haut a partir d'un filtre passe-bas.
H_ph = 1 - fspecial('gaussian', size(tfd), 0.5);

%%
% Application
tfd_passe_haut = ((tfd.*H_ph)/(min(min(H_ph))));

%%
% Affichage de l'image transform�e
img_passe_haut = uint8(abs(ifft2(ifftshift(tfd_passe_haut))));
figure;
imshow(img_passe_haut);
title('Image filtr�e (filtre passe-haut)')

%% Question 5

%%
% Cr�ation du filtre
[H_manches,] = imread('filtre_manches.png');
H_manches = double(rgb2gray(H_manches));

%%
% Application
tfd_manches = (tfd.*H_manches)/(15*max(max(H_ph)));

%%
% Affichage.
% Un petit bout du col reste visible, a cause de la difficult� de supprimer les pics correspondants lorsqu'ils
% sont tres proches de ceux correspondant aux manches.
img_manches = uint8(abs(ifft2(ifftshift(tfd_manches))));
figure;
imshow(img_manches);
title('Image filtr�e (filtre de la question 5)')

%% Question 6

%%
% Cr�ation du filtre
[H_non_torse,] = imread('filtre_non_torse.png');
H_non_torse = double(rgb2gray(H_non_torse));

%%
% Application
tfd_sans_torse = (tfd.*H_non_torse)/(max(max(H_non_torse)));

%%
% Affichage
% Le filtre cr�� a la main est loin d'�tre id�al, mais il est suffisant pour montrer la validit� de son principe :
% le filtre pr�c�dent masquait tout ce qui n'�tait pas les valeurs de la transform�e correspondant aux manches et
% son image �tait blanche sur ces parties (de fa�on assez grossiere) ;
% l'image du filtre utilis� est noire sur les parties de la repr�sentation de la transform�e qui correspondent au torse
% et laisse passer toutes les autres valeurs.
img_sans_torse = uint8(abs(ifft2(ifftshift(tfd_sans_torse))));
figure;
imshow(img_sans_torse);
title('Image filtr�e (filtre de la question 6');

%% Question 7

%%
% Un filtre de Butterworth est proche d'un filtre id�al (�limination plus ou moins pr�cise selon l'ordre du filtre de tout ce qui vient apres la coupure ; traitement uniforme des fr�quences venant avant la coupure) et l'approxime de mieux en mieux au fur et a mesure que l'on augmente son ordre.
% Il ne s'agit cependant pas d'un filtre id�al, seulement d'une tres bonne approximation.

%% Question 8

%%
% La composante continue de l'image est filtr�e et l'image contient des valeurs n�gatives/nulles a l'affichage.

%% Question 9

%%
% Il s'agit d'un filtre passe-haut dont on diminue progressivement la fr�quence de coupure, vu l'ordre d'affichage et les filtres r�alis�s plus haut.
