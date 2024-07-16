% Read Excel file
data = readtable('Results.xlsx', 'Sheet', 'Sheet3');

% Extract angle data
angles = data{2:end, 1};

% Initialize variables to store fitting parameters
a_values = [];
b_values = [];
c_values = [];

% Create a figure window
figure;

% Iterate over all dependent variable data columns (second column to the eleventh column)
for col = 2:11
    % Extract the dependent variable data for the current column
    angle2 = data{2:end, col};
    
    % Calculate the position of the subplot, e.g., 3 rows and 4 columns
    subplot(3, 4, col - 1); % Adjust rows, columns, and index as needed
    
    % Fit data to a quadratic function
    p = polyfit(angles, angle2, 2); % Returns [quadratic coefficient, linear coefficient, intercept]
    a = p(1); % Quadratic coefficient
    b = p(2); % Linear coefficient
    c = p(3); % Intercept
    
    % Plot scatter plot
    scatter(angles, angle2, 'filled');
    hold on; % Hold the current plot to overlay the fitted curve
    
    % Generate data points for the fitted curve
    x_fit = linspace(min(angles), max(angles), 100);
    y_fit = polyval([a, b, c], x_fit); % Use the fitting coefficients to generate the fitted curve data
    
    % Plot the fitted curve
    plot(x_fit, y_fit, 'r-', 'LineWidth', 1);
    
    % Set chart title and axis labels, and display the fitting coefficients
    title(sprintf('Curve %d: A=%.8f, B=%.8f, C=%.8f', col-1, a, b, c));
    xlabel('Angles (deg)');
    ylabel('angle2');
    
    % Store fitting parameters
    a_values = [a_values, a];
    b_values = [b_values, b];
    c_values = [c_values, c];
    
    hold off; % Release the hold to plot the next subplot
end

% Print average coefficients
a_average = mean(a_values);
b_average = mean(b_values);
c_average = mean(c_values);
fprintf('Average A: %.8f\n', a_average);
fprintf('Average B: %.8f\n', b_average);
fprintf('Average C: %.8f\n', c_average);

% % (Optional) Plot all fitted curves and scatter plots
% figure;
% hold on;
% for col = 2:11
%     scatter(angles, data{2:end, col}, 'filled');
%     x_fit = linspace(min(angles), max(angles), 100);
%     y_fit = polyval([a_values(col-1), b_values(col-1), c_values(col-1)], x_fit);
%     plot(x_fit, y_fit, 'r-', 'LineWidth', 1);
% end
% title('Scatter Plot with Fitted Quadratic Functions');
% xlabel('Angles (radians)');
% ylabel('angle2');
% legend(arrayfun(@(n) sprintf('Column %d', n), 2:11, 'UniformOutput', false));
% hold off;

% % Plot scatter plot
% figure(1);
% scatter(misalignments, misalignment1, 'filled');
% 
% % Fit data to a linear function
% p = polyfit(misalignments, misalignment1, 1); % Returns [slope, intercept]
% k = p(1); % Slope
% b = p(2); % Intercept
% k_formatted = sprintf('%.4f', k);
% b_formatted = sprintf('%.4f', b);
% 
% % Plot the fitted linear function line
% hold on;
% x_fit = linspace(min(misalignments), max(misalignments), 100); % Generate x values for plotting
% y_fit = polyval(p, x_fit); % Calculate fitted y values
% plot(x_fit, y_fit, 'r-');
% 
% % Display slope and intercept
% title('Force vs. Misalignment for Angle 2 deg');
% xlabel('Misalignment');
% ylabel('Force');
% legend('Points', ['y = (' num2str(k_formatted, '%.2f') ')x + (' num2str(b_formatted, '%.2f') ')']);
% % Hold the figure
% hold off;
% 
% figure(2);
% scatter(misalignments, misalignment2, 'filled');
% 
% % Fit data to a linear function
% p = polyfit(misalignments, misalignment2, 1); % Returns [slope, intercept]
% k = p(1); % Slope
% b = p(2); % Intercept
% k_formatted = sprintf('%.4f', k);
% b_formatted = sprintf('%.4f', b);
% 
% % Plot the fitted linear function line
% hold on;
% x_fit = linspace(min(misalignments), max(misalignments), 100); % Generate x values for plotting
% y_fit = polyval(p, x_fit); % Calculate fitted y values
% plot(x_fit, y_fit, 'r-');
% 
% % Display slope and intercept
% title('Force vs. Misalignment for Angle 4 deg');
% xlabel('Misalignment');
% ylabel('Force');
% legend('Points', ['y = (' num2str(k_formatted, '%.2f') ')x + (' num2str(b_formatted, '%.2f') ')']);
% % Hold the figure
% hold off;
% 
% figure(3);
% scatter(angles, angle1, 'filled');
% 
% % Fit data to a linear function
% p = polyfit(angles, angle1, 1); % Returns [slope, intercept]
% k = p(1); % Slope
% b = p(2); % Intercept
% k_formatted = sprintf('%.4f', k);
% b_formatted = sprintf('%.4f', b);
% 
% % Plot the fitted linear function line
% hold on;
% x_fit = linspace(min(angles), max(angles), 100); % Generate x values for plotting
% y_fit = polyval(p, x_fit); % Calculate fitted y values
% plot(x_fit, y_fit, 'r-');
% 
% % Display slope and intercept
% title('Force vs. Angle for Misalignment 2 mm');
% xlabel('Angle');
% ylabel('Force');
% legend('Points', ['y = (' num2str(k_formatted, '%.2f') ')x + (' num2str(b_formatted, '%.2f') ')']);
% % Hold the figure
% hold off;
% 
% figure(4);
% scatter(angles, angle2, 'filled');
% 
% % Fit data to a linear function
% p = polyfit(angles, angle2, 1); % Returns [slope, intercept]
% k = p(1); % Slope
% b = p(2); % Intercept
% k_formatted = sprintf('%.4f', k);
% b_formatted = sprintf('%.4f', b);
% 
% % Plot the fitted linear function line
% hold on;
% x_fit = linspace(min(angles), max(angles), 100); % Generate x values for plotting
% y_fit = polyval(p, x_fit); % Calculate fitted y values
% plot(x_fit, y_fit, 'r-');
% 
% % Display slope and intercept
% title('Force vs. Angle for Misalignment 4 mm');
% xlabel('Angle');
% ylabel('Force');
% legend('Points', ['y = (' num2str(k_formatted, '%.2f') ')x + (' num2str(b_formatted, '%.2f') ')']);
% % Hold the figure
% hold off;
