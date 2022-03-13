%% Main File
%% Section 1
clear
clc

% Create the regression model for (1) Force Length and (2) Force Velocity
% Declaring models as global variables so they can be used within the scope
% of other functions
global force_length_regression force_velocity_regression
force_length_regression = get_muscle_force_length_regression(); 
force_velocity_regression = get_muscle_force_velocity_regression();

%% Section 2: Question 1:
clc
plot_curves();

%% Section 3: Question 2:
clc

a = 1;
lm = 1;
lt = 1.01;
velocity = get_velocity(a, lm, lt);

%% Section 4: Question 3:
clc

T = 2;
f0M = 100;
resting_length_muscle = 0.3;
resting_length_tendon = 0.1;

% RelTol = 1e-6;
RelTol = 1e-3;
AbsTol = 1e-8;

tic
simulate(T, f0M, resting_length_muscle, resting_length_tendon, RelTol, AbsTol);
toc




