clear
clc


% Create the regression model for (1) Force Length and (2) Force Velocity
% Declaring models as global variables so they can be used within the scope
% of other functions
global force_length_regression force_velocity_regression tendon_force_length_regression parallel_force_length_regression
force_length_regression = get_muscle_force_length_regression();
force_velocity_regression = get_muscle_force_velocity_regression();
tendon_force_length_regression = get_tendon_force_length_regression();
parallel_force_length_regression = get_parallel_force_length_regression();

t = 0:0.01:1.2;
angle = 0;
angleVelocity = 0;
tibialis_norm_length_muscle = 1;
i=1;

activation = GetMuscleActivationFromWaveform(t, 'trap', 3, 20, 50);

for i=1:length(t)
T0 = t(i);
T1 = t(i+1);
initialCondition = [angle, angleVelocity, tibialis_norm_length_muscle];
a = activation(i);

[fm, y] = force(T0, T1, initialCondition, a);

angle = y(end,1);
angleVelocity = y(end,2);
tibialis_norm_length_muscle = y(end,2);

% [theta, toe_y] = GetTheta(fm);
% angle = theta(end);
end

