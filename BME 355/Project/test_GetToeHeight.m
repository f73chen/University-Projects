%% Test getting the toe height at various points in time
model = OpenSim('data/data.csv');   % Load data from OpenSim
l_foot = 0.21517;                   % 50-th percentile foot length

assert(GetToeHeight(model, 0, deg2rad(model.GetTilt(0))) == model.GetHeight(0), "Zero-time, horizontal");
assert(GetToeHeight(model, 1.2, deg2rad(model.GetTilt(1.2))) == model.GetHeight(1.2), "Final-time, horizontal");
assert(round(GetToeHeight(model, 0.3555, pi/4), 3) == round(model.GetHeight(0.3555), 3), "Tibia 45 forward, foot 45 up");
assert(round(GetToeHeight(model, 0.3555, -pi/4), 3) == round(model.GetHeight(0.3555)-l_foot, 3), "Tibia 45 forward, foot 45 down");
