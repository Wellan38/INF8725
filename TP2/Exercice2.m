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

res = Compter_Monnaie(ferm)

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
    
    radii = [200, 140, 120, 110, 90];
    values = [0, 2, 0.25, 0.05, 0.1];
    
    coins_map = containers.Map(radii, values);
    
    coins = [];
    
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
    
    for c = coins
        res = res + coins_map(c);
    end
end