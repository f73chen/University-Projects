function simulate(T, f0M, resting_length_muscle, resting_length_tendon, RelTol, AbsTol)
    % Input Parameters
    % T: simulation time (seconds)
    % f0M: maximum isometric force
    % resting_length_muscle: actual length (m) of muscle (CE) that corresponds to normalized length of 1
    % resting_length_tendon: actual length of tendon (m) that corresponds to normalized length of 1
    
    %%% TASK 1
    % Define the Hill-type muscle
    muscleModel = HillTypeMuscle(f0M, resting_length_muscle, resting_length_tendon);
    
    %%% TASK 2
    function [root] = vm_fct(t, x) 
        if t < 0.5 
            a = 0; 
        else 
            a = 1; 
        end 
        root = get_velocity(a, x, muscleModel.norm_tendon_length(resting_length_muscle + resting_length_tendon, x)); 
    end
    
    %%% TASK 3
    % the outputs of ode45 must be named "time" and "norm_lm"
    tspan = [0 T]; 
    initialCondition = 1; 
    options = odeset('RelTol', RelTol, 'AbsTol', AbsTol); 
    [time, norm_lm] = ode45(@vm_fct, tspan, initialCondition, options);
    
    %%% TASK 4
    forces = zeros(1, length(norm_lm)); 
    for i = 1:length(norm_lm)     
        forces(i) = muscleModel.get_force(resting_length_muscle + resting_length_tendon, norm_lm(i)); 
    end
    
    % Do not alter the rest (it should not be needed)
    norm_lm = norm_lm * resting_length_muscle;
    
    % Plot results
    figure()
    LineWidth = 1.5;
    FontSize = 12;
    
    subplot(2,1,1)
    plot(time, norm_lm, 'LineWidth', LineWidth)
    xlabel('Time (s)')
    ylabel('Normalized CE Length (m)')
    set(gca,'FontSize', FontSize)
    
    subplot(2,1,2)
    plot(time, forces, 'LineWidth', LineWidth)
    xlabel('Time (s)')
    ylabel('CE Tension (N)')
    set(gca,'FontSize', FontSize)
end