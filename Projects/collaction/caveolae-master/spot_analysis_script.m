% Spot analysis script
%
% This script performs the following tasks:
%
%  1. Load image files listed in spot_analysis_script.csv
%  2. Compute spot properties (area, mean intensity, integrated intensity)
%  3. Split the input grayscale image into punctate -vs- diffuse images
%  4. Compute relative distribution of puntate -vs- diffuse signal
%  5. Plot and save results
%
% (C) Raibatak Das, 2018
% MIT License

% Add functions to search path
addpath('spot_analysis_functions', '-end')

% Specify input table (leave filename unchanged for default) 
imageList = 'spot_analysis_input.csv';

% Run spot analysis
results = analyze_images(imageList);

% Plot spot intensity distributions
plot_spot_props(results.spotProperties)

% Save results (leave folder name unchanged for default)
outputFolder = 'spot_analysis_output';
save_output(results, outputFolder)
