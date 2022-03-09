function [] = simulate(T)
% Runs a simulation of the model and plots results.

% Inputs
% T: total time to simulate, in seconds

rest_length_soleus = soleus_length(pi/2);
rest_length_tibialis = tibialis_length(pi/2);

soleus = HillTypeMuscle(16000, 0.6*rest_length_soleus, 0.4*rest_length_soleus);
tibialis = HillTypeMuscle(2000, 0.6*rest_length_tibialis, 0.4*rest_length_tibialis);

f = @(t, x) dynamics(x, soleus, tibialis);

tspan = [0 T];
initialCondition = [pi/2, 0, 1, 1];
options = odeset('RelTol', 1e-6, 'AbsTol', 1e-8);
[time, y] = ode45(f, tspan, initialCondition, options);

theta = y(:,1);
soleus_norm_length_muscle = y(:,3);
tibialis_norm_length_muscle = y(:,4);

soleus_moment_arm = 0.05;
tibialis_moment_arm = 0.03;
soleus_moment = zeros(size(y,1),1);
tibialis_moment = zeros(size(y,1),1);
for i = 1:size(y,1)
    soleus_moment(i) = soleus_moment_arm * soleus.get_force(soleus_length(theta(i)), soleus_norm_length_muscle(i));
    tibialis_moment(i) = -tibialis_moment_arm * tibialis.get_force(tibialis_length(theta(i)), tibialis_norm_length_muscle(i));
end

figure()
LineWidth = 1.5;
subplot(2,1,1)
plot(time, theta, 'LineWidth', LineWidth)
ylabel('Body Angle (rad)')

subplot(2,1,2)
plot(time, soleus_moment, 'r', 'LineWidth', LineWidth), hold on
plot(time, tibialis_moment, 'g', 'LineWidth', LineWidth)
plot(time, gravity_moment(theta), 'k', 'LineWidth', LineWidth), hold off
legend('Soleus', 'Tibialis', 'Gravity', 'Location','northwest')
xlabel('Time (s)')
ylabel('Torques (Nm)')
set(gca,'FontSize',12)
end