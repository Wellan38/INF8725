%% Exercice 2

%%
% Nettoyage

clc;
clear all;
close all;

%% Question 1

%%
% Lecture et affichage de l'image en nuances de gris
[img, map] = imread('pieces.jpg');
img_gray = rgb2gray(img);

imshow(img_gray)
title('pieces.jpg')

%% Question 2

%%
% Binarisation de l'image
bin = 255 - Binariser(img, 250);

figure;
imshow(bin)
title('Image binarisée')

%% Question 3

%%
% Application de la fermeture a l'image binarisée
ferm = Fermeture(bin);

figure;
imshow(ferm)
title('Fermeture appliquée a l''image')

%% Question 4

%%
% Comptage des pieces
monnaie = Compter_Monnaie(ferm);
monnaie

%% Fonctions

%%
% Fonction de seuillage
function bin = Binariser(img, thresh)
    bin = 255 * (img >= thresh);
end

%%
% Fonction de fermeture
function res = Fermeture(img)
    % élément structurant
    se = strel('disk',10);
    
    % fermeture
    res = imclose(img, se);
end

%%
% Fonction de comptage de monnaie
function res = Compter_Monnaie(img)
    objects = bwlabel(im2bw(img));
    
    % Rayons des pieces connues, avec leurs valeurs correspondantes
    radii = [200, 140, 120, 110, 90];
    values = [0, 2, 0.25, 0.05, 0.1];
    
    coins_map = containers.Map(radii, values);
    
    coins = [];
    
    % On érode jusqu'a tomber sur un rayon connu
    for i = 1:length(unique(objects)) - 1
        obj = (objects == i);
        
        for r = radii
            se = strel('disk', r);
            dil = imerode(obj, se);
            
            if (ismember(1, dil))
                coins = [coins, r];
                break;
            end
        end
    end
    
    res = 0;
    
    % On somme les valeurs des pieces trouvées
    for c = coins
        res = res + coins_map(c);
    end
end