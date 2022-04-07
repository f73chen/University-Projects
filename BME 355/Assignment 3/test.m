clear
clc
model = Circulation(75, 2, 0.06);

%% Test task 2: switching between modes
% Filling phase
x1 = [0; 1; 0; 0];
assert(isequal(model.get_derivative(0, x1), model.filling_phase_dynamic_matrix(0)*x1));

% Ejection phase
x2 = [0; 0; 0; 1];
x3 = [1; 0; 0; 0];
assert(isequal(model.get_derivative(0, x2), model.ejection_phase_dynamic_matrix(0)*x2));
assert(isequal(model.get_derivative(0, x3), model.ejection_phase_dynamic_matrix(0)*x3));

% Isovolumetric phase
x4 = [0; 0; 0; 0];
x5 = [2; 1; 3; 0];
assert(isequal(model.get_derivative(0, x4), model.isovolumic_phase_dynamic_matrix(0)*x4));
assert(isequal(model.get_derivative(0, x5), model.isovolumic_phase_dynamic_matrix(0)*x5));

%% Test task 4 - Calculating aortic Q and plotting
T = 5;
[time, state] = model.simulate(T);
aortic_q = state(:, 1) - state(:, 4) .* model.R3;

figure()
LineWidth = 1.5;
FontSize = 12;
plot(time, state(:, 1), 'r', 'LineWidth', LineWidth), hold on
plot(time, state(:, 2), 'g', 'LineWidth', LineWidth)
plot(time, state(:, 3), 'b', 'LineWidth', LineWidth)
plot(time, aortic_q, 'k', 'LineWidth', LineWidth), hold off

legend('ventricular', 'atrial', 'arterial', 'aortic')
xlabel('Time (seconds)')
ylabel('Pressure (mmHg)')
set(gca, 'FontSize', FontSize)

%% Test task 3: simulating the dynamics
% Start with different initial conditions
cond1 = [0, 0, 0, 0];                                   % No blood in the heart
cond2 = [model.non_slack_blood_volume / model.C2, 0, 0, 0]; % All blood in the ventricle
cond3 = [0, 0, model.non_slack_blood_volume / model.C2, 0]; % All blood in the arteries

[time, state] = test_simulation(model, 5, cond3);
aortic_q = state(:, 3) + ...
           gradient(state(:, 4)) ./ gradient(time) .* model.L + ...
           state(:, 4) * model.R4;

figure()
LineWidth = 1.5;
FontSize = 12;
plot(time, state(:, 1), 'r', 'LineWidth', LineWidth), hold on
plot(time, state(:, 2), 'g', 'LineWidth', LineWidth)
plot(time, state(:, 3), 'b', 'LineWidth', LineWidth)
plot(time, aortic_q, 'k', 'LineWidth', LineWidth), hold off
legend('ventricular', 'atrial', 'arterial', 'aortic')
xlabel('Time (seconds)')
ylabel('Pressure (mmHg)')
set(gca, 'FontSize', FontSize)

function [time, y] = test_simulation(model, total_time, initialCondition)
    f = @(t, x) model.get_derivative(t, x);
    tspan = [0 total_time];
    options = odeset('RelTol', 1e-6, 'AbsTol', 1e-8);
    [time, y] = ode45(f, tspan, initialCondition, options);
end