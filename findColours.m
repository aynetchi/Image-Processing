% Function returns 4x4 array of strings representing color blocks 
function colourMatrix=findColours(img)
denoised = denoise(img); % Returns denoised image
transformed = transform(denoised); % Returns image block in black an white 
colournames = {'W','R','G','B','Y'}; % Specify colour names
colorcodes = [1 1 1; 1 0 0; 0 1 0; 0 0 1; 1 1 0]; % Specify colour code
[IMB, totalBlocks] = bwlabel(transformed); % segmenting the image regions with the square blocks 

% getting average color in each image mask region
averageColours = zeros(totalBlocks, 3); % Creating an empty array of three zero for each square block detected  

for blk = 1:totalBlocks % Looping through the detected blocks (16 blocks )
    val = IMB == blk; % Validation using boolean (0-1)
    region = denoised(val(:,:,[1 1 1])); % Finding regions 
    averageColours(blk,:) = mean(reshape(region,[],3),1); % Applying average color for each region
end

% Finding the centre of blocks 
centers = regionprops(transformed,'centroid'); % Centre of blocks 
centroids = vertcat(centers.Centroid); % Merging the central regions 
centroidlimits = [min(centroids,[],1); max(centroids,[],1)]; % Finding limits
centroids = round((centroids-centroidlimits(1, :)) ./ range(centroidlimits, 1) * 3 + 1);
% Rearraging the colours
idx = sub2ind([4 4], centroids(:, 2), centroids(:, 1));
averageColours(idx,:) = averageColours;
% Finding colour distances
distance = averageColours - permute(colorcodes, [3 2 1]);
distance = squeeze(sum(distance.^2, 2));
% Finding the index of the best match 
[~,idx] = min(distance, [], 2);
% Returning colours as 4x4 matrix
if totalBlocks ~= 16 % Error prevention 
    error('Unable to detect all the square blocks!') % Error message 
else 
    colourMatrix = reshape(colournames(idx), 4, 4);
end
end