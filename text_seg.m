%%
clear all;
close all;
clc;
workspace;
format long g;
format compact;
fontSize = 20;

% Image name
baseFileName = 'images.jpg';
folder = fileparts(which(baseFileName)); % Determine where demo folder is
fullFileName = fullfile(folder, baseFileName);
% Check if file exists.
if ~exist(fullFileName, 'file')
  % The file doesn't exist
  % Check the entire search path (other folders) for the file and strip off
  % the folder
  fullFileNameOnSearchPath = baseFileName; % No path this time.
  if ~exist(fullFileNameOnSearchPath, 'file')
    % Still didn't find it.  Alert !!
    errorMessage = sprintf('Error: %s does not exist in the search path folders.', fullFileName);
    uiwait(warndlg(errorMessage));
    return;
  end
end
%%
% Read in demo image.
rgbImage = imread(fullFileName);
% Get the dimensions of the image.
[rows, columns, numberOfColorChannels] = size(rgbImage);
% Display the original image.
subplot(2, 3, 1);
imshow(rgbImage, []);
axis on;
caption = sprintf('Original Color Image, %s', baseFileName);
title(caption, 'FontSize', fontSize, 'Interpreter', 'None');
hp = impixelinfo(); % Set up status line to see values when you mouse over the image.
% Set up figure properties:
% Enlarge figure to full screen.
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0.05 1 0.95]);
% Get rid of tool bar and pulldown menus that are along top of figure.
% set(gcf, 'Toolbar', 'none', 'Menu', 'none');
% Give a name to the title bar.
set(gcf, 'Name', 'Demo by ImageAnalyst', 'NumberTitle', 'Off')
drawnow;
% Get a gray scale version
grayImage = rgb2gray(rgbImage);
% Display the mask image.
subplot(2, 3, 2);
imshow(grayImage, []);
axis on;
title('Gray Scaled Image', 'FontSize', fontSize, 'Interpreter', 'None');
hp = impixelinfo(); % Set up status line to see values when you mouse over the image.
% Show histogram of range image.
subplot(2, 3, 3);
histogram(grayImage);
grid on;
title('Histogram of Gray Image', 'FontSize', fontSize, 'Interpreter', 'None');
% Get a mask of the colored images, which have high range.
binaryImage = grayImage < 220;
% Do an opening to break connections of text to photo.
binaryImage = imopen(binaryImage, ones(5));
% Fill in holes.
binaryImage = imfill(binaryImage, 'holes');
% Filter out blobs smaller than 50 pixels by 50 pixels.
binaryImage = bwareafilt(binaryImage, [50*50, inf]);
% Display the mask image.
subplot(2, 3, 4);
imshow(binaryImage, []);
title('Photo Regions', 'FontSize', fontSize, 'Interpreter', 'None');
% Get a mask of the dark stuff.
darkStuff = rgb2gray(rgbImage) < 250;
% Display the text regions.
subplot(2, 3, 5);
imshow(darkStuff, []);
title('Dark Regions', 'FontSize', fontSize, 'Interpreter', 'None');
% Enlarge the photo region somewhat.
photoRegion = imdilate(binaryImage, ones(15));
% Mask out the photo regions.
textRegions = darkStuff & ~photoRegion;
% Connect things horizontally, like words that are spaced far apart.
textRegions = imclose(textRegions, ones(1, 9));
% Fill in holes and get convex hull.
textRegions = bwconvhull(textRegions, 'objects');
% Display the mask image.
subplot(2, 3, 6);
imshow(textRegions, []);
axis on;
title('Text Regions', 'FontSize', fontSize, 'Interpreter', 'None');