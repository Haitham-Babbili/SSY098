function data = read_txt( filt_path )
% Read data from txt file

fid = fopen(filt_path,'r');
data = [];

while 1
    
    tline = fgetl(fid);
    
    if ~ischar(tline)
        break
    end
    
    tline = str2num(tline);
    data = [data; tline];
    
end

fclose(fid);

end

