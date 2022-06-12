function data = read_txt( file_path )
%READ_TXT Read data from txt file.
%   Input argument:
%   - file_path : the path of the txt file that needs to be load
%   Output:
%   - data : the data that is read from the txt file

% Open the file
fid = fopen(file_path,'r');

% Initialize the data to store the content of the file
data = [];

while 1
    
    % Read each line in the file
    tline = fgetl(fid);
    
    if ~ischar(tline)
        break
    end
    
    % Convert string to numeric data
    tline = str2num(tline);
    
    % Put the data in to the matrix
    data = [data; tline];
    
end

% Close the file
fclose(fid);

end

