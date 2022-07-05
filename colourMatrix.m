% Function undistorts double precision images and return array of string for each colour 
function colourArray = colourMatrix(filename)
img = loadImage(filename);
undistortedImage = correctImage(img); % Undistorting the images 
imshow(undistortedImage)
colourArray = findColours(undistortedImage); % Output of identified colour as 4x4 array of strings
end

