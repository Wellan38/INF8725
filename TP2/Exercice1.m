%% Nettoyage préliminaire

clc;
clear all;
close all;

%% Exercice 1 : Filtrage spatial

%% Question 1

[img, map] = imread('theArtist.png');
img_eq = Egalisation_Histogramme(img);

imshow(img)

%imshow(img_eq, map)

%% Question 2
% Masque :
mask = [
        1, 1, 1;
        1, 1, 1;
        1, 1, 1
        ] / 9;

% res = Convolution(img_eq, mask);
% imshow(res, map)

%% Question 3
% Masque :
mask = [
        1, 2, 1, 2, 1;
        2, 4, 8, 4, 2;
        1, 8, 18, 8, 1;
        2, 4, 8, 4, 2;
        1, 2, 1, 2, 1
        ] / 90;

res = Convolution(img_eq, mask, 'uint8');
%imshow(res, map)

%% Question 4
[img_g, img_l] = Rehaussement_Contour(res, 0.6);
figure;
imshow(img_g, map)

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
