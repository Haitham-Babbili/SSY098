function [imgs, labels] = nread_data(imgfile, labelFile, n, offset)

tt=imgfile;
fid = fopen(tt, 'r', 'b');
fid
header = fread(fid, 1, 'int32');

% error checker
if header ~= 2051
    error('Invalid image file header');
end

% retrieve the number of images
count = fread(fid, 1, 'int32');
if count < n+offset
    error('Trying to read too many digits');
end

h = fread(fid, 1, 'int32');
w = fread(fid, 1, 'int32');

if offset > 0
    fseek(fid, w*h*offset, 'cof');
end

imgs = zeros([h*w, n]);

for i=1:n
    imgs(:,i) = fread(fid, h*w, 'uint8');
end

fclose(fid);
%%
% Read digit labels
fid = fopen(labelFile, 'r', 'b');
header = fread(fid, 1, 'int32');

% Error checker
if header ~= 2049
    error('Invalid label file header');
end

count = fread(fid, 1, 'int32');
if count < n+offset
    error('Trying to read too many digits');
end

if offset > 0
    fseek(fid, offset, 'cof');
end

labels = fread(fid, n, 'uint8');
fclose(fid);

% Calc avg digit and count
%     imgs = trimDigits(imgs, 4);
imgs = normalizePixValue(imgs);