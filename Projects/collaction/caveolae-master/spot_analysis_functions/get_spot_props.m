function spotProps = get_spot_props(grayscaleImg, spotsMask)
  % Calculate area, mean intensity and total intensity of each detected spot
  %
  % Inputs
  %  grayscaleImg: Grayscale caveolin image
  %  spotsMask: binary mask of detected spots
  %
  % Output
  %  spotProps: An n-by-4 table with one row per spot and the following columns:
  %
  %  | SpotID | SpotArea | MeanIntensity | TotalIntesity |
  %
  %  SpotID: 1, 2, ..., n
  %  SpotArea
  %
  % (C) Raibatak Das, 2018
  % MIT License

  cc = bwconncomp(spotsMask);
  features = regionprops(cc, grayscaleImg, 'Area', 'MeanIntensity');
  spotArea = [features.Area]';
  meanIntensity = [features.MeanIntensity]';
  totalIntensity = spotArea .* meanIntensity;
  nSpots = length(features);
  spotProps = array2table([[1:nSpots]', spotArea, meanIntensity totalIntensity], ...
                          'VariableNames', ...
                          {'SpotID', 'SpotArea', 'MeanIntensity', 'TotalIntensity'});
end
