function save_to_file( path, recall, precision )
%SAVE_TO_FILE Save recall and precision of one predicted result to text
%file with the given path.
%   Input arguments :
%   - path : the path that the text file will be saved in, including the
%   name of folder and the name of text file
%   - recall : a vector contains recall for every instance
%   - precision : a vector contains precision for every instance

% Alphabet contains all 26 characters
alphabet = 'abcdefghijklmnopqrstuvwxyz';

% If the folder is not exist, create the folder
if ~exist('Results', 'dir') == 1
   mkdir('Results');
end

% If the text file is already existed, delete it
if exist(path, 'file')
    delete(path)
end

% Create a file with the given path
fid = fopen(path,'a+');

% Print character, recall and precision in each column
fprintf(fid, 'Char\tPrecision\tRecall\r\n');
for i = 1 : 26
    
    fprintf(fid, '%c\t%.2f\t\t%.2f\r\n', ...
            alphabet(i), precision(i), recall(i));
        
end

% Close the file
fclose(fid);
    
end