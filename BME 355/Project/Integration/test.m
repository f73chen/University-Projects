%% OpenSim dataset interpolation
model = OpenSim('data/data.csv');

% Constructor
assert(~isempty(model.table), "Couldn't read from CSV");
assert(~isempty(model.tilt), "Couldn't load tibia tilt from CSV")
assert(~isempty(model.height), "Couldn't load tibia height from CSV")

% Reading the actual values
assert(model.GetTilt(0) == model.tilt(1), "Tilt(0) doesn't match");
assert(model.GetTilt(1.2) == model.tilt(73), "Tilt(-1) doesn't match");
assert(model.GetHeight(0.01) > model.height(1), "Height interpolation failed (1)");
assert(model.GetHeight(0.01) < model.height(2), "Height interpolation failed (2)");
