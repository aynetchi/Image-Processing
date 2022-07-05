% Converts image to double precison type 
function [img] = loadImage(filename)
img = imread(filename); %read the image file
img = double(img)/255; % Convert to double precision
if isa(img,'uint8') == 1 % Error prevention
    error('Ensure image is type unit 8'); % Error message
end
end