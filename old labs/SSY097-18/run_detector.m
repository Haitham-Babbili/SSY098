%---------------------------------------------------------------%
%   run_detector -- finds blood cells in an image               %
%                                                               %
%   input - img is a color image with values between 0 and 1    %
%   output - 2 x n array with coordinates of blood cells        %        
%---------------------------------------------------------------%

function detections = run_detector(img)

    load('my_network.mat','net');
    
    stride = 4;                     %  Higher --> Speeds up computation
    std = 1;                        % Standard deviation of Gaussian filter 
    threshold = 0.1;                % Threshold applied in strict_local_maxima

    % Compute probability map in a sliding window manner. Send output to
    % strict_local_maxima which performs non-maximum suppression and
    % thresholding and returns (x,y) coordinates of detected blood cells. 
    probmap = sliding_cnn(net, img, stride); 
    maxima = strict_local_maxima(probmap, threshold, std);

    % Rescale probmap to corresponding img-coordinates 
    detections = (maxima -1) * stride + 1; 

end