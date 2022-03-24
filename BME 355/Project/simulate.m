function [] = simulate(T, start, stop, type, amp, freq, duty, phase)
    % Runs a simulation of the model and plots results.
    
    % Inputs
    % T: total time to simulate, in seconds
    
    rest_length_tibialis = tibialis_length(0);
    tibialis = HillTypeMuscle(2000, 0.6*rest_length_tibialis, 0.4*rest_length_tibialis);
    
    model = OpenSim('data/data.csv');   % Load data from OpenSim
    f = @(t, x) dynamics(t, start, stop, x, tibialis, model, type, amp, freq, duty, phase);
    
    % Run the simulation
    tspan = [start stop];
    initialCondition = [0, 0, 1];
    options = odeset('RelTol', 1e-6, 'AbsTol', 1e-8);
    [time, y] = ode45(f, tspan, initialCondition, options);
    
    % Display simulation results
    theta = y(:,1);
    tibialis_norm_length_muscle = y(:,3);
    
    tibialis_moment_arm = 0.03;
    tibialis_moment = zeros(size(y,1),1);
    for i = 1:size(y,1)
        tibialis_moment(i) = tibialis_moment_arm * tibialis.get_force(tibialis_length(theta(i)), tibialis_norm_length_muscle(i));
    end
    
    figure()
    LineWidth = 1.5;
    subplot(3,1,1)
    plot(time, theta, 'LineWidth', LineWidth)
    ylabel('Ankle Angle (rad)')
    
    subplot(3,1,2)
    plot(time, tibialis_moment, 'g', 'LineWidth', LineWidth), hold on
    plot(time, -gravity_moment(theta, time, model), 'k', 'LineWidth', LineWidth), hold off
    legend('Tibialis', 'Gravity', 'Location','northwest')
    xlabel('Time (s)')
    ylabel('Torques (Nm)')
    set(gca,'FontSize',12)

    subplot(3, 1, 3)
    plot(time, GetToeHeight(model, time, theta), 'b', 'LineWidth', LineWidth)
    xlabel('Time (s)')
    ylabel('Toe height (m)')
end