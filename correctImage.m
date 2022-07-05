% function that adjusts distorted images and rotates based on "org_1.png"
function undistorted= correctImage(img)
refferenceImage = loadImage('org_1.png'); % Using the org_1 image as refference for rotation
bwImg =~ im2bw(img, 0.5); % Converting the image to black and white
imgFilled = imfill(bwImg,'holes'); % Filling elements detected in white 
gaussFilt = fspecial('Gaussian',[3 3],2); % Creating a Gaussian type filter. 
filtered = imfilter(imgFilled, gaussFilt); % Denoising the image using the Gaussian filter.
elements = bwconncomp(filtered); % Locating connected elements in the image 
imgData = regionprops(filtered,'Area','Centroid'); % Finding the area and centroids in the filtered image.
Blocks = zeros(elements.ImageSize); % Creating an array of zeros with the shape of the square blocks using size of the image in number of pixels

for B = 1:elements.NumObjects % Filling in area with the square blocks with ones 
    if imgData(B).Area<max([imgData.Area]) 
        Blocks(elements.PixelIdxList{B}) = 1; 
    end
end

centroids = [regionprops(bwlabel(Blocks, 8),'Area','Centroid').Centroid]; % Locating centroids for connected elements
refPoints = transpose(reshape(centroids,2,[])); % Reshaping matrix array 
staticPoints = flip(findCircles(refferenceImage)); % Setting the fixed points as centroids of org_1.png
sizeRef = imref2d(size(refferenceImage)); % Referencing the size of org_1.png
rotate = fitgeotrans(refPoints,staticPoints,'Projective'); % applying the transformation 
% Output - Identifying pixel values using reference image and distorted image 
undistorted = imwarp(img,rotate,'OutputView',sizeRef);
%imshow(undistorted) % Displaying distorted image and corrected image side by side 
end