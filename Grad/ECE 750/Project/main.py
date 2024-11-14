from option_critic import OptionCriticFeatures

oc = OptionCriticFeatures(in_features=1,
                          num_actions=1,
                          num_options=1)
oc.save("models/oc_1.pt")
oc.load("models/oc_1.pt")