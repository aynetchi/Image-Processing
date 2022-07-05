% Functiomn identifying the circles in the images and marking it in red
function [centpt, R] = findCircles(image)
%imshow(image)
[centpt, R] =  imfindcircles(image,[15 25],'ObjectPolarity','dark','Sensitivity',0.93,'Method','twostage'); % Returns coordiates of the circle on the images 
%circle = viscircles(centpt, R) % Circle surfaced marked in red 
end


