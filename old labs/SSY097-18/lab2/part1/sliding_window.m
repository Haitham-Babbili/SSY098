function probmap = sliding_window(img, w, w0)

    p = @(y) (1+exp(-y)).^-1;           % Sigmoid function
    
    ytemp = zeros(size(img)); 
    
    % Filter img in all 3 color channels
    for i=1:size(img,3)
    ytemp(:,:,i) = imfilter(img(:,:,i),w(:,:,i)) + w0;
    end
    
   y = sum(ytemp,3);        % Sum over 3d to get 2d matrix
   probmap = p(y);          % Return probmap [0,1] 
    
    

    
    
end

