clear; clc; close all;
%% calculate LST(land surface temperature) with two method.
% First method is called single channal and the seconf one is calculate by
% Plank's law. For the first place is need to calculate Emessivity and then
% calculate LST. This code is written for Landsat 8.
disp(['Welcome to your LST code. At the first place i should tell you write your input image' ...
    'adress in input section of script. so if do not this i finish code,'])
disp('write you adresses and then run. After that choose your LST method. Thanks.')
disp('Do you write your input adresses? if yes write -1- and if no write -0-.')
in = input('write your answer...');
switch in
    case 0
    case 1
        disp('1.single channel method')
        disp('2.Planks Law method')
        in = input('whitch method do you want o run? enter its number...');

        %% read inputs.
        BT = double(geotiffread('D:\test4\2019_BT_mosaic.tif')); %Put brigthness temperature image adress.
        radiance = double(geotiffread('D:\test4\2019_radiance_mosaic.tif')); %Put radiance image adress.
        info = geotiffinfo('D:\test4\2019_radiance_mosaic.tif'); %Put one of images adress.
        [image, ref] = geotiffread('D:\test4\2019_reflectance_mosaic.tif'); %Put reflectance image adress.
        image = double(image);
        % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
        % separate bands.
        B1 = image(:,:,1);  B2 = image(:,:,2);
        B3 = image(:,:,3);  B4 = image(:,:,4);
        B5 = image(:,:,5);  B6 = image(:,:,6);
        B7 = image(:,:,7);
        % some parameters.
        [row,col,band] = size(image);
        Emissivity = []; % For store emissivity image.
        % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
        % calculate NDVI and FVC.
        NDVI = (B5-B4)./(B5+B4);
        h = waitbar(0, 'calculate FVC. please wait...');
        for i = 1:size(NDVI,1)
            waitbar(i/size(NDVI,1),h)
            for j = 1:size(NDVI,2)
                FVC(i,j) = ((NDVI(i,j) - 0.1)./(max(max(NDVI)) - 0.1)).^2;
            end
        end
        close(h)
        % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
        % calculate Emissivity.
        h = waitbar(0, 'calculate Emissivity. please wait...');
        for i = 1:size(NDVI,1)
            waitbar(i/size(NDVI,1),h)
            for j = 1:size(NDVI,2)
                if NDVI(i,j) < 0
                    Emissivity(i,j) = 0.991;
                elseif (NDVI (i,j) >= 0 && NDVI (i,j) < 0.1)
                    Emissivity(i,j) = 0.979 - 0.046 * B4(i,j);
                elseif  NDVI (i,j) < 0.6 && NDVI (i,j) >= 0.16
                    Emissivity(i,j) = (0.987 .* FVC(i,j)) +  (0.971 .* (1 - FVC(i,j)));
                else
                    Emissivity(i,j) = 0.99;
                end
            end
        end
        close(h)

        switch in
            case 1
                % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
                disp('calculate single channel LST')
                wv = input('input water vapor value...');
                khi1 = (0.4019 .* (wv .^ 2))+(0.02916 .* wv) + 1.01523;
                khi2 = (-0.38333 .* (wv .^ 2))+(-1.50294 .* wv) + 0.20324;
                khi3 = (0.00918 .* (wv .^ 2))+(1.36072 .* wv) - 0.27514;
                gamma = ((BT .^ 2) ./ (2324 .* radiance));
                sigma = BT - ((BT .^ 2)./1324);
                LST = (gamma .* ((1 ./ Emissivity) .* (((khi1 .* radiance) + khi2) + khi3))) + sigma;

                % save image in device.
                [f p] = uiputfile({'*.tif'},'save your NDVI image...');
                if f == 0 && p == 0
                else
                    geotiffwrite([p f], NDVI, ref, 'GeoKeyDirectoryTag', info.GeoTIFFTags.GeoKeyDirectoryTag)
                end
                [f p] = uiputfile({'*.tif'},'save your LST image(single channel)...');
                if f == 0 && p == 0
                else
                    geotiffwrite([p f], LST, ref, 'GeoKeyDirectoryTag', info.GeoTIFFTags.GeoKeyDirectoryTag)
                end
                % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
            case 2
                LST = (BT./(1+(0.00115 .* BT ./ 1.4388) .* log10(Emissivity)));
                % save image in device.
                [f p] = uiputfile({'*.tif'},'save your NDVI image...');
                if f == 0 && p == 0
                else
                    geotiffwrite([p f], NDVI, ref, 'GeoKeyDirectoryTag', info.GeoTIFFTags.GeoKeyDirectoryTag)
                end
                [f p] = uiputfile({'*.tif'},'save your LST image(single channel)...');
                if f == 0 && p == 0
                else
                    geotiffwrite([p f], LST, ref, 'GeoKeyDirectoryTag', info.GeoTIFFTags.GeoKeyDirectoryTag)
                end
        end
end

















