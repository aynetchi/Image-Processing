% Function that returns denoised image 
function denoised=denoise(img)
filtered = medfilt3(img,[11 11 1]); % Applying median filter to denoise the image 
darkened = imadjust(filtered,stretchlim(filtered, 0.27)); % Reduces brighness of the image 
metrics = strel('square', 9); % Metrics used as parameter for erosion and dialation 
eroded = imerode(darkened,metrics); % Erosion applied to cancel the blurred image 
denoised = imdilate(eroded,metrics); % Dialtion applied for final touches 
end
