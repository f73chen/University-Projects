%% OpenSim dataset interpolation
model = OpenSim('data/data.csv');

% Constructor
assert(~isempty(model.table), "Couldn't read from CSV");
assert(~isempty(model.ankle_angle), "Couldn't load ankle angle from CSV")
assert(~isempty(model.tilt), "Couldn't load tibia tilt from CSV")
assert(~isempty(model.height), "Couldn't load tibia height from CSV")

% Reading beyond range [0, 1.2]
assert(model.GetAnkleAngle(-1) == model.ankle_angle(1), "Failed to zero ankle angle below time range");
assert(model.GetAnkleAngle(2) == model.ankle_angle(end), "Failed to zero ankle angle above time range")
assert(model.GetTilt(-1) == model.tilt(1), "Failed to zero tilt below time range");
assert(model.GetTilt(2) == model.tilt(end), "Failed to zero tilt above time range")
assert(model.GetHeight(-1) == model.height(1), "Failed to zero height below time range");
assert(model.GetHeight(2) == model.height(end), "Failed to zero height above time range")

% Reading within the range
assert(model.GetAnkleAngle(0) == model.ankle_angle(1), "AnkleAngle(0) doesn't match");
assert(model.GetAnkleAngle(1.2) == model.ankle_angle(end), "AnkleAngle(-1) doesn't match");
assert(model.GetTilt(0) == model.tilt(1), "Tilt(0) doesn't match");
assert(model.GetTilt(1.2) == model.tilt(end), "Tilt(-1) doesn't match");
assert(model.GetHeight(0) == model.height(1), "Height(0) doesn't match");
assert(model.GetHeight(1.2) == model.height(end), "Height(-1) doesn't match");

% Interpolation
assert(model.GetAnkleAngle(0.01) > model.ankle_angle(1), "AnkleAngle interpolation failed (1)");
assert(model.GetAnkleAngle(0.01) < model.ankle_angle(2), "AnkleAngle interpolation failed (2)");
assert(model.GetTilt(0.01) > model.tilt(1), "Tilt interpolation failed (1)");
assert(model.GetTilt(0.01) < model.tilt(2), "Tilt interpolation failed (2)");
assert(model.GetHeight(0.01) > model.height(1), "Height interpolation failed (1)");
assert(model.GetHeight(0.01) < model.height(2), "Height interpolation failed (2)");
