% Define known parameters
m = 0.216;       % Workpiece mass (kg)
h = 0.08;        % Workpiece height (m)
J = m*(3*0.02^2 + h^2)/12 + m*h/4;  % Moment of inertia (kg*m^2)

A =  0.00012999*(180/pi)^2; 
B = -0.00002058*(180/pi); 
D = -0.0008*1000; 
C = 2.9764;

R = 0.185;       % Pendulum arm length (m)
r = 0.1;         % Swing arm length (m)

% Initial conditions
theta_0 = 0;          % Initial angle (rad)
theta_dot_0 = 0.2;    % Initial angular velocity (rad/s)

% Initial state vector
y0 = [theta_dot_0; theta_0]; % Initial angular velocity and angle

% Time span
tspan = [0 0.6]; % Simulation time span (s)

% Number of simulations
numSimulations = 40; % Number of simulations

% Set color sequence
colors = lines(numSimulations);

% Create figure window 1 - Angle vs. Time
figure(1);
hold on; % Hold current figure
title('Angle vs. Time', 'FontSize', 18);
xlabel('Time (s)', 'FontSize', 18);
ylabel('Angle (deg)', 'FontSize', 18);
grid on;
set(gca, 'FontSize', 18); % Set axis font size

% Create figure window 2 - Angular Velocity vs. Time
figure(2);
hold on; % Hold current figure
title('Angular Velocity vs. Time', 'FontSize', 18);
xlabel('Time (s)', 'FontSize', 18);
ylabel('Angular Velocity (rad/s)', 'FontSize', 18);
grid on;
set(gca, 'FontSize', 18); % Set axis font size

% Perform multiple simulations
for i = 1:numSimulations
    % Generate random values for d, delta_t, k1, k2 for each simulation
    d = 0.05 * randn();
    delta_t = 0.01 + 0.01 * rand();  
    k1 = 0.005 + 0.005 * rand(); 
    k2 = 25 + 10 * rand(); 
    v0 = pi * R / (3 + 0.5 * rand());     

    % Calculate force f
    f = m * v0 / delta_t; % Force (N)
    
    % Define differential equation function odefunc
    odefunc = @(t, y) ([ 
        y(2),  % theta_dot (angular velocity)
        (((A * y(1)^2 + B * y(1) + C + D * d) * (-d) + k1 * y(2) + k2 * y(1) + 0.5 * m * 9.81 * h * y(2) - 0.5 * f * h) / (-J))  % theta_ddot with negative sign on the left side accounted for
    ]);

    % Solve differential equations using ode45
    [t, y] = ode45(@(t, y) odefunc(t, y), tspan, y0);
    
    % Plot angle vs. time curve
    figure(1); % Switch to figure window 1
    plot(t, y(:,2), 'Color', colors(i, :));
    
    % Plot angular velocity vs. time curve
    figure(2); % Switch to figure window 2
    plot(t, y(:,1), 'Color', colors(i, :));
end

% Hold off plotting
hold off;
