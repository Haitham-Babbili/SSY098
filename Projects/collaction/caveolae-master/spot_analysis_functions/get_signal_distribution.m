function [punctateImg, diffuseImg, signalDistribution] = ...
    get_signal_distribution(grayscaleImg, spotsMask, diffuseMask)
  % Split grayscale image into punctate and diffuse images, and compute 
  % distribution of total signal in punctate and diffuse partitions
  %
  % Inputs
  %  grayscaleImg: Grayscale caveolin image
  %  spotsMask: Binary mask of detected spots on the plasma membrane
  %  diffuseMask: Complementary mask of membrane minus detected spots
  %
  % Outputs
  %  spots: A grayscale image that shows only punctate spots
  %  diffuse: Complementary grayscale image that shows only diffuse signal
  %  signalDistribution: Table of signal distribution metrics
  %
  % (C) Raibatak Das, 2018
  % MIT License

  % Convert masks to logical arrays if necessary
  if not(islogical(spotsMask))
      spotsMask = logical(spotsMask);
  end
  if not(islogical(diffuseMask))
      diffuseMask = logical(diffuseMask);
  end
  
  % Split original image into punctate and diffuse parts
  punctateImg = immultiply(grayscaleImg, spotsMask);
  diffuseImg = immultiply(grayscaleImg, diffuseMask);
  
  % Compute signal distribution
  npunctate = sum(spotsMask(:));
  ndiffuse = sum(diffuseMask(:));
  punctate_signal = sum(double(punctateImg(:)));
  diffuse_signal = sum(double(diffuseImg(:)));
  d2p_ratio = diffuse_signal/punctate_signal;
  d2p_meanIntensity = (diffuse_signal/ndiffuse) / (punctate_signal/npunctate);
  
  % Create output table
  signalDistribution = ...
    array2table([[npunctate], [ndiffuse], [punctate_signal], [diffuse_signal], ...
                 [d2p_ratio], [d2p_meanIntensity]], 'VariableNames', ...
                 {'PunctatePixels', 'DiffusePixels', 'PunctateSignal', ...
                  'DiffuseSignal', 'RatioD2P_totalSignal', ...
                  'RatioD2P_meanIntensity'});
end