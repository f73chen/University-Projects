function [muscle_activation] = GetMuscleActivationFromWaveform(t, start, stop, type, amp, freq, duty, phase)
    % Define the sigmoid function
    function y = sigmoid(x, max_voltage)
        x = x - max_voltage/2;
        y = 1 ./ (1 + exp(-x));
    end

    % Initialize waveform
    waveform = GetWaveform(t, start, stop, type, amp, freq, duty, phase);
    
    % Get the unmodified sigmoid waveform
    max_voltage = 10;     % Max FES output (assume 10 V)
    muscle_activation = sigmoid(waveform, max_voltage);

    % Stretch the y-axis so [0, max] maps to [0, 1]
    vertical_stretch = 1 / (sigmoid(max_voltage, max_voltage) - sigmoid(0, max_voltage));
    muscle_activation = ((muscle_activation - 0.5) .* vertical_stretch) + 0.5;
end