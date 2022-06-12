function out = apply_exhaustive(net, img, radius)

if strcmp(net.layers{end}.type, 'loss')
    net.layers(end) = [];
elseif strcmp(net.layers{end}.type, 'softmaxloss')
    net.layers{end}.type = 'softmax';
end

% Pad the image with the latger radius
% The padding part is symmetric as the boundary region of image
pad_image = padarray(img, [radius radius], 'symmetric');

% Initialize the return variable
% Here, there are 6 classes in my training set
[rows, cols, ~] = size(img);
out = zeros(rows, cols, 6);

h = waitbar(0, 'Detecting cells in image ...');
for kk = 1 : rows
    
    for mm = 1 : cols
        
        % Extract the patch from padded image
        temp = pad_image(kk:kk+2*radius, mm:mm+2*radius, :);
        % Normalize the patch by subtracting its own mean
        patch(:,:,:,mm) = 255*(bsxfun(@minus, temp, mean(mean(temp))));
        
    end
    
    res = vl_simplenn(net, single(patch), [], [], 'mode', 'test') ;
    s2 = squeeze(res(end).x);
    
    for i = 1 : cols
        % Put the result into 'out'
        % In 'out', each pixel has 6 values, 
        % each value is the probability for one class
        out(kk, i, :) = s2(:,i);
    
    end
    
    waitbar(kk / rows)
    
end
close(h)

end