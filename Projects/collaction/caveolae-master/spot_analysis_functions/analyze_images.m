function results = analyze_images(imageList)
  % Wrapper function for complete spot intensity analysis
  %
  % This function performs the following tasks:
  % 1. Load image files from the input table
  % 2. Compute spot properties (area, mean intensity, integrated intensity)
  % 3. Split the input grayscale image into punctate -vs- diffuse images
  % 4. Compute relative distribution of puntate -vs- diffuse signal
  % 
  % The output is a structure with the following fields:
  %   spotProps: Table of properties for each detected spot
  %   punctateImage: Image of punctate signal
  %   diffuseImage: Complementary image of diffuse signal
  %   intensityDistribution: Table of relative signal distribution between 
  %                          puncate and diffuse partitions
  % 
  % (C) Raibatak Das, 2018
  % MIT License
  [I, spotsMask, diffuseMask] = load_images(imageList);

  % 2. Compute spot properties
  spotProps = get_spot_props(I, spotsMask); 

  % 3. Split original image, and
  % 4. Compute relative distribution of signal between punctate and diffuse
  %    partitions
  [punctateImage, diffuseImage, intensityDistribution] = ...
      get_signal_distribution(I, spotsMask, diffuseMask);
  
  % Print output summary
  fprintf("Results: %d spots detected \n\n", height(spotProps))
  % fprintf("    Diffuse -vs- punctate signal distribution summary:\n ")
  disp(intensityDistribution)
  
  % Create output structure
  results.spotProperties = spotProps;
  results.punctateImage = punctateImage;
  results.diffuseImage = diffuseImage;
  results.intensityDistribution = intensityDistribution;
end