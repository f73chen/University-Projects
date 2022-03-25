function [] = simulate(T, type, amp, freq, duty, phase)
    % Runs a simulation of the model and plots results.
    
    % Inputs
    % T: total time to simulate, in seconds
    
    rest_length_tibialis = tibialis_length(0);
    tibialis = HillTypeMuscle(2000, 0.6*rest_length_tibialis, 0.4*rest_length_tibialis);
    
    model = OpenSim('data/data.csv');
    f = @(t, x) dynamics(t, x, tibialis, model, type, amp, freq, duty, phase);
    
    % Run the simulation
    tspan = [0 T];
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
    vLineWidth = 1;
    subplot(3,1,1)
    plot(time, theta, 'LineWidth', LineWidth)
    xline(0.35, '--r', 'LineWidth', vLineWidth)
    xline(0.95, '--r', 'LineWidth', vLineWidth)
    ylabel('Ankle Angle (rad)')
    set(gca,'FontSize',12)
    
    subplot(3,1,2)
    plot(time, tibialis_moment, 'g', 'LineWidth', LineWidth), hold on
    plot(time, -gravity_moment(theta, time, model), 'k', 'LineWidth', LineWidth), hold off
    legend('Tibialis', 'Gravity', 'Location','northwest','AutoUpdate','off')
    xlabel('Time (s)')
    ylabel('Torques (Nm)')
    xline(0.35, '--r', 'LineWidth', vLineWidth)
    xline(0.95, '--r', 'LineWidth', vLineWidth)
    set(gca,'FontSize',12)

    subplot(3, 1, 3)
    plot(time, GetToeHeight(model, time, theta), 'b', 'LineWidth', LineWidth)
    xline(0.35, '--r', 'LineWidth', vLineWidth)
    xline(0.95, '--r', 'LineWidth', vLineWidth)
    xlabel('Time (s)')
    ylabel('Toe height (m)')
    set(gca,'FontSize',12)
end