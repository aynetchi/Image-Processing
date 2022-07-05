% Function returns image block in black an white 
function transformed=transform(denoised)
grayscaled= rgb2gray(denoised) > 0.08; % converting the image into greyscale 
removeBorders = imclearborder(grayscaled); % Clear image borders to focus on the square blocks 
transformed = imerode(removeBorders, ones(10)); % Erosion applied to mask edges that may be altered 
%imshow([grayscaled, transformed])
end
