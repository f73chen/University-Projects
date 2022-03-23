function [fm] = force(T,initialCondition, a);
% Inputs
% T: total time to simulate, in seconds
% initialCondition: array with initial angle, angular velocity (=0?), TA normalized CE length
% a: muscle activation

rest_length_tibialis = tibialis_length(pi/2);
tibialis = HillTypeMuscle(2000, 0.6*rest_length_tibialis, 0.4*rest_length_tibialis);

f = @(t, x) dynamics(x, tibialis, a);
tspan = [0 T];

options = odeset('RelTol', 1e-6, 'AbsTol', 1e-8);
[time, y] = ode45(f, tspan, initialCondition, options);

theta = y(:,1);
tibialis_norm_length_muscle = y(:,3);

for i = 1:size(y,1)
    fm(i) = tibialis.get_force(tibialis_length(theta(i)), tibialis_norm_length_muscle(i));
end
%%
figure()
LineWidth = 1.5;
subplot(2,1,1)
plot(time, theta, 'LineWidth', LineWidth)
ylabel('Body Angle (rad)')

subplot(2,1,2)
plot(time, fm, 'g', 'LineWidth', LineWidth)
xlabel('Time (s)')
ylabel('Torques (Nm)')
set(gca,'FontSize',12)

end