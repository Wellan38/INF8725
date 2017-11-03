%% Exercice 1 : Filtrage spatial

%%
% Nettoyage
clc;
clear all;
close all;

%% Question 1

%%
% Lecture de l'image et �galisation de son histogramme
[img, map] = imread('theArtist.png');
img_eq = Egalisation_Histogramme(img);

imshow(img)
title('theArtist.png')

figure;
imshow(img_eq, map)
title('Image apres �galisation de son histogramme')

%% Question 2

%%
% Masque :
mask = [
        1, 1, 1;
        1, 1, 1;
        1, 1, 1
        ] / 9;

%%
% Image filtr�e
res = Convolution(img_eq, mask, 'uint8');
imshow(res, map)
title('Image filtr�e')

%% Question 3

%%
% Masque :
mask = [
        1, 2, 1, 2, 1;
        2, 4, 8, 4, 2;
        1, 8, 18, 8, 1;
        2, 4, 8, 4, 2;
        1, 2, 1, 2, 1
        ] / 90;

%%
% Image filtr�e
res = Convolution(img_eq, mask, 'uint8');
imshow(res, map)
title('Image filtr�e')

%% Question 4

%%
% R�haussement des contours. Nous avons choisi K = 0.6, car 1.2 d�formait
% trop l'image.
[img_g, img_l] = Rehaussement_Contour(res, 0.6);
figure;
imshow(img_g, map)
title('Image avec contours r�hauss�s')

%% Question 5
% Un bruit de type poivre-et-sel persiste sur l'image. On peut l'enlever
% avec un filtre m�dian.

%% Fonctions

%%
% Fonction d,�galisation d'histogramme
function res = Egalisation_Histogramme(img)
    histo = zeros(1, 256);
    [height, width] = size(img);
    
    for i = 1:height
        for j = 1:width
            val = img(i, j) + 1;
            histo(1, val) = histo(1, val) + 1;
        end
    end
    
    cumul = zeros(1, 256);
    for i = 1:255
        for j = 1:i
            cumul(1, i) = cumul(1, i) + histo(1, j);
        end
    end
    
    cumul = cumul / (height * width);
    
    res = zeros(height, width);
    
    for i = 1:height
        for j = 1:width
            res(i, j) = round(255 * cumul(1, img(i, j) + 1));
        end
    end
end


%%
% Fonction de convolution
function res = Convolution(img, mask, type)
    [height, width] = size(img);
    mask_dim = size(mask);
    mask_dim = mask_dim(1);
    padding = (mask_dim - 1) / 2;
    
    padded_img = zeros(height + 2 * padding, width + 2 * padding);
    res = zeros(height, width);
    
    padded_img(1 + padding:height + padding, 1 + padding:width + padding) = img;
   
    for i = 1:height
        for j = 1:width
            mult = double(padded_img(i:i + 2 * padding, j:j + 2 * padding)) .* mask;
            
            if(strcmp(type, 'double'))
                res(i, j) = sum(sum(mult));
            elseif(strcmp(type, 'uint8'))
                res(i, j) = uint8(sum(sum(mult)));
            end
        end
    end
end

%%
% Fonction de r�haussement de contours
function [img_r, img_l] = Rehaussement_Contour(img, K)
    G = [
            1, 2, 1;
            2, 4, 2;
            1, 2, 1
        ] / 16;
    
    L = [
            -1, -1, -1;
            -1, 8, -1;
            -1, -1, -1;
        ];
    
    img_g = Convolution(img, G, 'uint8');
    img_l = Convolution(img_g, L, 'double');
    img_r = uint8(img_g + K * img_l);
    img_l = uint8(img_l);
end
