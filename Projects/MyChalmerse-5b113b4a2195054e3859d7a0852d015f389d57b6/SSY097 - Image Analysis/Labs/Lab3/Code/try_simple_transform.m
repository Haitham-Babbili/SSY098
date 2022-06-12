function try_simple_transform( img )
%TRY_SIMPLE_TRANSFORM Apply simple transformation on the input image,
%including rotation, scaling and translation.
%   Input argument:
%   - img : an image that will be transformed
% Author: Qixun Qu

% Four examples(Ep) to show how to deal with 
% rotation, scaling and translation transform
% Ep1 : no transformation, show original image
% Ep2 : contrarotate pi/4 rad
% Ep3 : double the scale of original image
% Ep4 : translation along the positive orentation of axis
%         Ep1     Ep2       Ep3     Ep4
theta = [ 0,      pi/4,     0,      0         ];
scale = [ 1,      1,        2,      1         ];
trans = [ 0,0;    0,0;      0,0;    -100,-100 ];

% Obtain the size of transformed image,
% which is same as input image
target_size = size(img);

% Carry out the transformatio on imput image,
% and plot four results
figure
hold on

for i = 1 : 4
    
    % Calculate the transform matrix A
    % A consists of two parts: scaling part and rotation part
    % A = | scale    0   | * |  cos(theta)  -sin(theta)  |
    %     |   0    scale |   |  sin(theta)   cos(theta)  |
    A = 1/scale(i) * eye(2) * ...
         [cos(theta(i)) -sin(theta(i)); sin(theta(i)), cos(theta(i))];
    
    % Obtain the transformed image
    warped = affine_warp(target_size, img, A, trans(i,:)');
    
    % Plot result
    subplot(2, 2, i)
    imagesc(warped)
    axis image; axis off
    
end

hold off

end