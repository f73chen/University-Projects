%% OpenSim dataset interpolation
data = Database('data/data.csv');

% Constructor
assert(~isempty(data.table), "Couldn't read from CSV");
assert(~isempty(data.tilt), "Couldn't load tibia tilt from CSV")
assert(~isempty(data.height), "Couldn't load tibia height from CSV")

% Reading the actual values
assert(data.GetTilt(0) == data.tilt(1), "Tilt(0) doesn't match");
assert(data.GetTilt(1.2) == data.tilt(73), "Tilt(-1) doesn't match");
assert(data.GetHeight(0.01) > data.height(1), "Height interpolation failed (1)");
assert(data.GetHeight(0.01) < data.height(2), "Height interpolation failed (2)");
