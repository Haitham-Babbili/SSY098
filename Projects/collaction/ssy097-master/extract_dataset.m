%   Extract 29x29x3 patches from dataset images         %
%   Assumes dataset & get_patches() is on file path     %
%                                                       %    
%   Output: patchesPositive.mat & patchesNegative.mat   %
%-------------------------------------------------------%

clc
clear all



%-------------------%
% Step 1: load data %
%-------------------%

data = {zeros(2,50)};   % Pre-allocate data container
Nimg = 50;

for i=1:Nimg
        src = 'img_'; 
        centers = load([src num2str(i) '.mat']);    
        img = read_image([src num2str(i) '.png']); 
        
        data{1,i} = centers.cells;        
        data{2,i} = img;
end





%------------------------------------%
% Step 2: extract 'positive' patches %
%------------------------------------%


patches = {};   % Container for patches
patchIdx = 0;   % 
radius = 14;    % Gives 29x29-patches


for j=1:Nimg    % Iterate over all elements in data
    
    % Get current image and cell centers
    image  = data{2,j};
    centers = data{1,j};
    
    
    
    % Prepare some variables we will need
    imgSize = size(image);
    Ylen = imgSize(1);
    Xlen = imgSize(2);
    
    
    
    % Step 3: extract positive patches
    for k=1:length(centers)
                        
        patchIdx = patchIdx + 1;    % Increment index
        
        x = ceil(centers(1,k));     % Make sure indexes are integers
        y = ceil(centers(2,k));     %         
        
        % Check if x,y is inside image-borders        
        if y > Ylen-radius || x > Xlen-radius || y < radius+1 || x < radius+1                       
            % Not within borders - roll back index 
            patchIdx = patchIdx - 1;                      
        else                     
            % Is withihn borders - save patch and continue
            patches{patchIdx} = get_patch(image, x, y, radius); 
                      
        end
        
                
    end   
   
end


% Save to file
save('patchesPositive.mat','patches');

clear('patches')


%------------------------------------%
% Step 3: extract 'negative' patches %
%------------------------------------%


patches = {};
patchIdx = 0;

for j=1:Nimg
    
    image  = data{2,j};
    centers = ceil(data{1,j});

    imgSize = size(image);
    Ylen = imgSize(1);
    Xlen = imgSize(2);
    
    for k=1:length(centers)
        
        patchIdx = patchIdx + 1;
        
        % Randomize center-coordinates. 14<abs(x)<30
        % This will generate patches where cells are off-center
        match = true;        
        while match
            
                x = centers(1,k) + (-1)^(randi([0 1]))*randi([radius 30]);
                y = centers(2,k) + (-1)^(randi([0 1]))*randi([radius 30]);
                
                % Make sure that new x,y-coordinates don't exist in
                % centers-array for positive patches.
                xtmp = find(x == centers(1,:));
                ytmp = find(y == centers(2,:));
                
                % If no match then set to false and proceed
                if isempty(xtmp) && isempty(ytmp)
                    match = false;
                end
        end
        
        if y > Ylen-radius || x > Xlen-radius || y < radius+1 || x < radius+1
            patchIdx = patchIdx - 1;
        else
            patches{patchIdx} = get_patch(image, x, y, radius);
        end 
          
    end
        
end

save('patchesNegative.mat','patches');


clear all
