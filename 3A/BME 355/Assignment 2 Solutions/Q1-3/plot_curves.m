function plot_curves()

% Plot force-length, force-velocity, SE, and PE curves.

lm = 0:0.01:1.8;
vm = -1.2:0.01:1.2; 
lt = 0:0.01:1.07; 

LineWidth = 1.5;
FontSize = 12;

subplot(2,1,1)
plot(lm, force_length_muscle(lm), 'r', 'LineWidth', LineWidth), hold on
plot(lm, force_length_parallel(lm), 'g', 'LineWidth', LineWidth)
plot(lt, force_length_tendon(lt), 'b', 'LineWidth', LineWidth), hold off
axis([-0.1 1.85 0 1.6])
legend('CE', 'PE', 'SE', 'Location','northwest')
xlabel('Normalized length')
ylabel('Force scale factor')
set(gca,'FontSize', FontSize)

subplot(2, 1, 2)
plot(vm, force_velocity_muscle(vm), 'k', 'LineWidth', LineWidth)
xlabel('Normalized muscle velocity')
ylabel('Force scale factor')
axis([-1.3 1.3 0 1.35])
set(gca,'FontSize', FontSize)
end