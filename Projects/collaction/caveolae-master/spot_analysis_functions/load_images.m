function [image, spotsMask, diffuseMask] = load_images(imageList)
  % Load input images for spots analysis
  %
  % Input
  %   imageList: csv file with image folder and file names
  %
  % Outputs
  %   image: Grayscale (single channel) image
  %   spotsMask: Logical mask of detected spots on membrane
  %   diffuseMask: Complementary mask (membrane minus detected spots)
  % 
  % (C) Raibatak Das, 2018
  % MIT License
  
  tbl = readtable(imageList);
  srcdir = tbl.Path{:};
  % 1. Grayscale image
  filename = fullfile(srcdir, tbl.Image{:});
  fprintf("Loading input images:\n")
  fprintf("    Grayscale: %s\n", filename)
  image = imread(filename);
  % 2. Membrane mask
  filename = fullfile(srcdir, tbl.MembraneMask{:});
  fprintf("    Membrane mask: %s\n", filename)
  M = logical(imread(filename));
  % 3. Spots mask
  filename = fullfile(srcdir, tbl.SpotsMask{:});
  fprintf("    Spots mask: %s\n\n", filename)
  S = logical(imread(filename));
  
  % Generate punctate -vs- diffuse membrane masks
  spotsMask = M & S;
  diffuseMask = M & not(S);
end

  