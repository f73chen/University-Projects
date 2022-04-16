function [fm, y] = force(T0, T1,initialCondition, a);
% Inputs
% T: total time to simulate, in seconds
% initialCondition: array with initial angle, angular velocity , TA normalized CE length
% a: muscle activation

rest_length_tibialis = tibialis_length(0);
tibialis = HillTypeMuscle(2000, 0.6*rest_length_tibialis, 0.4*rest_length_tibialis);

f = @(t, x) dynamics(x, tibialis, a);
tspan = [T0 T1];

options = odeset('RelTol', 1e-6, 'AbsTol', 1e-8);
[time, y] = ode45(f, tspan, initialCondition, options);

theta = y(:,1);
angleVelocity = y(:,2);
tibialis_norm_length_muscle = y(:,3);

for i = 1:size(y,1)
    fm(i) = tibialis.get_force(tibialis_length(theta(i)), tibialis_norm_length_muscle(i));
end
%%
figure(1)
LineWidth = 1.5;
subplot(2,1,1)
plot(time, theta, 'LineWidth', LineWidth)
ylabel('Body Angle (rad)')
hold on;
subplot(2,1,2)
plot(time, fm, 'g', 'LineWidth', LineWidth)
xlabel('Time (s)')
ylabel('Torques (Nm)')
set(gca,'FontSize',12)
hold on;

end