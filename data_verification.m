% Read Excel file
data = readtable('Results.xlsx', 'Sheet', 'Sheet3');

% Extract angle data
angles = data{2:end, 1}; % 10x1 vector

% Extract misalignment data
misalignments = data{1, 2:end}; % 1x11 vector

% Extract force data
forces = table2array(data(2:end, 2:end)); % 10x11 matrix

% Define range for angles and misalignments
angle_min = 0;
angle_max = 5;
misalignment_min = 0;
misalignment_max = 4;

% Set step size for angles and misalignments
angle_step = 0.1;
misalignment_step = 0.1;

% Preallocate matrices
[angle_values, misalignment_values] = meshgrid(linspace(angle_min, angle_max, 100), ...
                                               linspace(misalignment_min, misalignment_max, 100));

% Given model parameters
a = 0.00012999;
b = -0.00002058; 
m = -0.0008;

% Initialize constant term c
c = 2.9764; % Initial constant term

% Compute F values
F = a * angle_values.^2 + b * angle_values + m * misalignment_values + c;

% Plot 3D surface
figure(1);
surf(angle_values, misalignment_values, F);
hold on;

% Generate grid for angles and misalignments
[angle_grid, misalignment_grid] = meshgrid(angles, misalignments);

% Mark data points in red
for i = 1:length(angles)
    for j = 1:length(misalignments)
        plot3(angles(i), misalignments(j), forces(i, j), 'r.', 'MarkerSize', 15);
    end
end

xlabel('Angle', 'FontSize', 18);
ylabel('Misalignment', 'FontSize', 18);
zlabel('F', 'FontSize', 18);
title('Surface plot with data points', 'FontSize', 18);

colorbar; % Show color bar
set(colorbar, 'FontSize', 18); % Set font size for color bar
view(157, 11);

% Add legend and set its position
legend({'Model Surface', 'Data Points'}, 'FontSize', 18, 'Location', 'best', 'Orientation', 'vertical');

hold off;

% Separate influences

% Define range for angles and misalignments
angle_range = 0:0.1:5; % 0 to 5 with step size of 0.1
misalignment_range = 0:0.1:4; % 0 to 4 with step size of 0.1

% Compute F values
F_angle = a * angle_range + c; % Fixed misalignment = 0
F_misalignment = b * misalignment_range + c; % Fixed angle = 0

% Create figure window
figure(2);

% Plot F vs. angle
subplot(2, 1, 1); % First subplot in a 2x1 grid
plot(angle_range, F_angle, 'b-');
xlabel('Angle', 'FontSize', 18);
ylabel('F', 'FontSize', 18);
title('F vs. Angle (Misalignment = 0)', 'FontSize', 18);

% Plot F vs. misalignment
subplot(2, 1, 2); % Second subplot in a 2x1 grid
plot(misalignment_range, F_misalignment, 'r-');
xlabel('Misalignment', 'FontSize', 18);
ylabel('F', 'FontSize', 18);
title('F vs. Misalignment (Angle = 0)', 'FontSize', 18);

% Adjust spacing between subplots
subplot(2, 1, 1);
axis tight;
set(gca, 'FontSize', 18); % Set font size for the subplot

subplot(2, 1, 2);
axis tight;
set(gca, 'FontSize', 18); % Set font size for the subplot
