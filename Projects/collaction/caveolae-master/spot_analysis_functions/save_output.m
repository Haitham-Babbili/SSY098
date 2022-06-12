function save_output(results, outdir)
  % Save output of spot intensity analysis
  %
  % (c) Raibatak Das, 2018
  % MIT License
  
  % Save spot properties table
  dest = fullfile(outdir, 'spotProperties.csv');
  fprintf('Saving spot properties to %s \n', dest)
  writetable(results.spotProperties, dest)
  
  % Save intensity distribution
  dest = fullfile(outdir, 'intensityDistribution.csv');
  fprintf('Saving intensity distribution to %s \n', dest)
  writetable(results.intensityDistribution, dest)
  
  % Save punctate image
  dest = fullfile(outdir, 'punctateImage.tif');
  fprintf('Saving punctate image to %s \n', dest)
  imwrite(results.punctateImage, dest)
  
  % Save diffuse image
  dest = fullfile(outdir, 'diffuseImage.tif');
  fprintf('Saving diffuse image to %s \n', dest)
  imwrite(results.diffuseImage, dest)
end