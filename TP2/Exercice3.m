%% Exercice 3 : Transformée de Fourier 2D

%%
% Nettoyage
clc;
clear all;
close all;

%% Question 1

%%
% Chargement des images :
[img_vert, map_vert] = imread('Barres_Verticales.png');
[img_hor, map_hor] = imread('Barres_Horizontales.png');
[img_obl, map_obl] = imread('Barres_Obliques.png');

%%
% Affichage des images :
imshow(img_vert)
title('Barres\_Verticales.png')
figure()
imshow(img_hor)
title('Barres\_Horizontales.png')
figure()
imshow(img_obl)
title('Barres\_Obliques.png')

%% Question 2

%%
% TFD recentrée des images
tf_vert = fftshift(abs(fft2(img_vert)));
tf_hor = fftshift(abs(fft2(img_hor)));
tf_obl = fftshift(abs(fft2(img_obl)));

figure()
imshow(log(1+tf_vert), [])
title('TFD de l''image Barres\_Verticales.png')
figure()
imshow(log(1+tf_hor), [])
title('TFD de l''image Barres\_Horizontales.png')
figure()
imshow(log(1+tf_obl), [])
title('TFD de l''image Barres\_Obliques.png')

%% Question 3

%%
% Rotation d'image
img_vert_rot = imrotate(img_vert, 70, 'bilinear', 'crop');

%%
% TFD
tf_vert_rot = fftshift(abs(fft2(img_vert_rot)));
figure()
imshow(log(1+tf_vert_rot), [])
title('TFD de l''image tournée')

%% Question 4
% On peut inférer le comportement de la TFD lorsque l'image d'origine subit une rotation (le résultat également).
% On peut aussi observer la conservation de la symétrie par la TFD.
