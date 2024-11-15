import torch
import numpy as np

# TODO: Check outputs
def actor_loss(model, target_model, obs, option, reward, next_obs, done, logp, entropy):
    assert option is not None
    
    obs_tensor      = torch.tensor(obs,      dtype=torch.float32).reshape(1, -1).to(model.device)
    next_obs_tensor = torch.tensor(next_obs, dtype=torch.float32).reshape(1, -1).to(model.device)
    state      = model.features(obs_tensor)
    next_state = model.features(next_obs_tensor)
    
    # Detach everything related to the target model
    next_state_target = target_model.features(next_obs_tensor).detach() # [1, state_size]
    
    # β(s',o) --> Probability of terminating in the next state given the current option
    # Detach because it's part of gt
    next_termination_prob = model.terminations(next_state)[:, option].sigmoid().detach()    # [1]
    
    # Q(s',o) --> The Q_Omega value in the next state given the current option
    # Use the target network to estimate Q_Omega
    # Detach because it's part of gt and target_model
    next_Q_Omega_target = target_model.Q(next_state_target).squeeze()[option].detach() # Scalar
    
    # max_o' Q(s', o') --> The max Q_Omega value in the next state over all options
    # Use the target network to estimate Q_Omega
    # Detach because it's part of gt and target_model
    max_Q_Omega_target = target_model.Q(next_state_target).squeeze().max(dim=-1)[0].detach()   # Scalar

    # gt = r + γ * [(1 − β(s',o)) * Q(s',o) + β(s',o) * max_o' Q(s', o')]
    # gt = reward + discount * [prob_continue_next_state * curr_option_value_for_next_state + prob_terminate_next_state * max_option_value_for_next_state]
    # Detach gt itself (fixed reference value)
    gt = reward + (1 - done) * model.gamma * ((1 - next_termination_prob) * next_Q_Omega_target + next_termination_prob * max_Q_Omega_target).detach()
    
    # Probability of terminating in the current state given the current option
    termination_prob = model.terminations(state)[:, option].sigmoid()
    
    # Q_Omega values for all options
    Q_Omegas = model.Q(state).squeeze()
    
    # The advantage of continuing the current option vs. switching to the best option
    continue_advantage = Q_Omegas[option] - Q_Omegas.max(dim=-1)[0]
    
    # Higher loss if high termination prob with positive continue advantage
    termination_loss = (1 - done) * termination_prob * (continue_advantage + model.termination_reg)
    
    # Add entropy regularization to encourage higher entropy (uncertainty)
    Q_est_err = gt - Q_Omegas[option]
    
    # The intra-option policy's W and b are updated through logp
    policy_loss = -logp * Q_est_err - model.entropy_reg * entropy
    
    actor_loss = termination_loss + policy_loss
    return actor_loss

# The critic updates using a batch instead of every interaction for Q estimate stability
def critic_loss(model, target_model, batch):
    # Extract interactions from the batch
    # Note: They already are tensors on model.device
    obs, options, rewards, next_obs, dones = batch
    idx = torch.arange(model.batch_size).long()
    
    obs_tensor      = obs.reshape(model.batch_size, -1)
    next_obs_tensor = next_obs.reshape(model.batch_size, -1)
    states      = model.features(obs_tensor)
    next_states = model.features(next_obs_tensor)
    
    # See actor_loss about detach
    next_states_target = target_model.features(next_obs_tensor).detach()                        # [batch_size, state_size]
    next_termination_prob = model.terminations(next_states)[idx, options].sigmoid().detach()    # [batch_size]
    next_Q_Omega_target = target_model.Q(next_states_target)[idx, options].detach()             # [batch_size]
    max_Q_Omega_target = target_model.Q(next_states_target).max(dim=-1)[0].detach()             # [batch_size]
    gt = rewards + (1 - dones) * model.gamma * ((1 - next_termination_prob) * next_Q_Omega_target + next_termination_prob * max_Q_Omega_target).detach()    # [batch_size]

    # Backprop error through model.Q
    Q_Omegas = model.Q(states)[idx, options]  # [batch_size]
    
    # loss = 1/2 * E[ error^2 ]
    td_error = (Q_Omegas - gt).pow(2).mul(0.5).mean()
    return td_error
    
