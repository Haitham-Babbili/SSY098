function Ps_cell = convert_to_cell( Ps )
%CONVERT_PS_TO_CELL Convedrt the matrix Ps to a cell.
%   Input arguments:
%   - Ps : a 3x4n matrix contains n camera matrix
%   Output:
%   - Ps_cell : a cell contains n 3x4 camera matrix
% Author: Qixun Qu

% Compute the length of the cell
% since each camera matrix has 12 elements
cell_len = length(Ps(:)) / 12;

% Initialize the cell
Ps_cell = cell(1, cell_len);

for i = 1 : cell_len
    % Extract the ith camera matrix form Ps
    % anf put it into the ith position in cell
    Ps_cell{i} = reshape(Ps(12*i-11:12*i), 3, 4);
        
end

end