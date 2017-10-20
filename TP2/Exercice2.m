clc;
clear all;

% Question 1

[img, map] = imread('pieces.jpg');
img_gray = rgb2gray(img);

imshow(img_gray)

% Question 2

bin = 255 - Binariser(img, 250);

figure;
imshow(bin)

% Question 3

ferm = Fermeture(bin);

figure;
imshow(ferm)

% Question 4

Compter_Monnaie(ferm);

function bin = Binariser(img, thresh)
    [height, width] = size(img);
    bin = 255 * (img >= thresh);
end

function res = Fermeture(img)
    se = strel('disk',10);
            
    res = imclose(img, se);
end

function res = Compter_Monnaie(img)
    objects = bwlabel(im2bw(img));
    
    for i = 1:length(unique(objects)) - 1
        obj = (objects == i);
        figure;
        imshow(mat2gray(uint8(255 / i * obj)))
    end
end