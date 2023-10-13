% This script collects the data sent from the Arduino Mega.  It collects 
% the Loop Frequency (Freq) in Hz, the Duration of the Test (Time) 
% in seconds, the Reference Input vector (R) in units dependent on the type
% of test and the Output vector (Y) in radians. 

% Setup comport
comport = input('Which COM port is the Electronic Hardware Module attached to? [i.e. COM1, COM2, ... etc.]: ','s');
arduino = serial(comport,'BaudRate',115200); 
fopen(arduino);
 
disp('Press button to start data capture.')

clear Y;
clear T;
clear R;

% Read in inital values
Freq = fscanf(arduino,'%f');      % Read in Sample Frequency in Hz
Time = fscanf(arduino,'%f');      % Read in Duration of Test in seconds
H_Gain = fscanf(arduino,'%f');    % Read in Feedback gain
cnt_max = round(Freq*Time);       % Calculate total # of time steps
T = linspace(0,Time,cnt_max);     % Setup Time Vector

% Read in loop values
for i=1:cnt_max
   
  R(i)=fscanf(arduino,'%f');      % Read in reference input
  Y(i)=fscanf(arduino,'%f');      % Read in output in encoder counts
  
end
   
% Close comport
fclose(arduino);

disp('Data capture complete.')

% Convert Y from encoder counts to radians where H_Gain is the Feedback 
% gain in encoder counts per radian
Y = Y/H_Gain;

% Plot captured data
figure;
plot(T,R)
grid on
title('Reference Input vs. Time');
ylabel('Reference Input');
xlabel('Time (seconds)');

figure;
plot(T,Y)
grid on
title('Output vs. Time');
ylabel('Angular Position (radians)');
xlabel('Time (seconds)');

disp('Plotting complete.')



