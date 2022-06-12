function plot_spot_props(spotProps)
  % Plot output of spot intensity analysis
  %
  % (c) Raibatak Das, 2018
  % MIT License
  
  % 1. Plot cdf of spot intensities
  x = spotProps.TotalIntensity;
  cdf = ecdf95(x);
  m = median(x);
  
  figure('Color', 'w')
  stairs(cdf.xs, cdf.f, 'LineWidth', 2);
  hold all
  stairs(cdf.xs, cdf.lb, '-', 'LineWidth', 1);
  ax = gca;
  ax.ColorOrderIndex = 2;
  stairs(cdf.xs, cdf.ub, '-', 'LineWidth', 1)
  % Overlay median
  plot(m, 0.5, 'o', 'MarkerSize', 12, 'LineWidth', 2, ...
       'MarkerFaceColor', 'r', 'MarkerEdgeColor', 'w')
  set(gca, 'xscale', 'log')
  grid on
  xlabel('Integrated spot intensity')
  ylabel('Cumulative frequency')
  title('Integrated spot intensity distribution')
  
  % 2. Plot spot area -vs- mean intensity
  figure('Color', 'w')
  c = [0, 0.4470, 0.7410];
  s = scatter(spotProps.SpotArea, spotProps.MeanIntensity, 64, "o", ...
              'MarkerFaceColor', c, 'MarkerEdgeColor', c);
  %s.MarkerFaceAlpha = 0.7;
  %s.MarkerEdgeAlpha = 0.7;
  alpha(s, 0.7);
  grid on
  xlabel('Spot area (px^2)')
  ylabel('Mean spot intensity')
  title('Spot size and mean intensity distribution')
end