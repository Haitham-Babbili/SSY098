function plot_fit( b, S_fit, y_label )
%%PLOT_FIT Plot fitting results.

figure
plot(b, S_fit{1}, 'Marker', 'o', 'LineWidth', 1.2), grid on
hold on
plot(b, S_fit{2}, 'Marker', 'o', 'LineWidth', 1.2)
plot(b, S_fit{3}, 'Marker', 'o', 'LineWidth', 1.2)
plot(b, S_fit{4}, 'Marker', 'o', 'LineWidth', 1.2)
set(gca, 'FontSize', 12)
xlabel('b-factor (s/{mm^2})')
ylabel(y_label)
legend('Real Data', 'L-Fit Data', 'NL-Fit Data', 'NLA-Fit Data')

end

