%% Nettoyage

clc;
clear all;
close all;
%pkg load image signal % octave

%% Exercice 3 : Transformée de Fourier 2D

%% Question 1
% Chargement des images :
[img_vert, map_vert] = imread('Barres_Verticales.png');
[img_hor, map_hor] = imread('Barres_Horizontales.png');
[img_obl, map_obl] = imread('Barres_Obliques.png');

% Affichage des images :
imshow(img_vert)
figure()
imshow(img_hor)
figure()
imshow(img_obl)

%ginput()

%% Question 2
% TFD recentrée des images (normalisation ?)
tf_vert = fftshift(abs(fft2(img_vert)));
tf_hor = fftshift(abs(fft2(img_hor)));
tf_obl = fftshift(abs(fft2(img_obl)));

figure()
imshow(log(1+tf_vert), [])
% Note : pas de différence avec fftshift(abs(1+log(img_vert)))
figure()
imshow(log(1+tf_hor), [])
figure()
imshow(log(1+tf_obl), [])
title('TFD de l''image Barres\_Obliques.png')

%% Question 3
% Rotation d'image
img_vert_rot = imrotate(img_vert, 70, 'bilinear', 'crop');

% TFD
tf_vert_rot = fftshift(abs(fft2(img_vert_rot)));
figure()
imshow(log(1+tf_vert_rot))

%% Question 4
% On peut inférer de ces résultats la sensibilité au changement de phase.
% On peut aussi inférer son comportement lorsque l'image d'origine subit une rotation.

% ginput() % octave-cli
