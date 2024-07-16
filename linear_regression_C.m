% Read Excel file
data = readtable('Results.xlsx', 'Sheet', 'Sheet3');

% Extract angle data
angles = data{2:end, 1}; % 10x1 vector
angles = angles(:); % Convert to column vector

% Extract misalignment data
misalignments = data{1, 2:end}; % 1x11 vector

% Extract force data
forces = table2array(data(2:end, 2:end)); % 10x11 matrix

% Given model parameters
a = 0.00012999;
b = -0.00002058;
m = -0.0008;

% Initialize constant term c
c = 2.9766; % Initial constant term

% Construct predicted force matrix
predicted_forces = a * angles.^2 + b * angles + c + m * misalignments;

% Compute the error between predicted and actual values
errors = forces - predicted_forces;

% Compute the current SSE for c
SSE = sum(errors(:).^2); % Use vectorized operation

% Compute the current MSE for c
MSE_current = SSE / numel(forces);

% Output the current MSE
fprintf('Current MSE with c = %.8f: %.8f\n', c, MSE_current);

% Try different c values to find the c that minimizes MSE
c_values = 2.9760:0.0001:2.9770; % Search around 2.9766
MSE_values = zeros(size(c_values));

for k = 1:length(c_values)
    c = c_values(k);
    % Recompute predicted forces using the current c value
    predicted_forces = a * angles.^2 + b * angles + c + m * misalignments;
    % Compute the error for the current c value
    errors_k = forces - predicted_forces;
    % Compute the SSE for the current c value
    SSE_values(k) = sum(errors_k(:).^2); % Use vectorized operation
    % Compute the MSE for the current c value
    MSE_values(k) = SSE_values(k) / numel(forces);
end

% Find the c value that minimizes MSE
[optimal_MSE, idx] = min(MSE_values);
optimal_c = c_values(idx);

% Output the optimal c value and corresponding minimum MSE
fprintf('Optimal c value that minimizes MSE: %.8f\n', optimal_c);
fprintf('Minimum MSE achieved: %.8f\n', optimal_MSE);
