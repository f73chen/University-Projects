import torch
import numpy as np

# TODO: Check outputs
def actor_loss(model, target_model, obs, option, reward, next_obs, done, logp, entropy):
    obs_tensor      = torch.tensor(obs,      dtype=torch.float32).reshape(1, -1).to(model.device)
    next_obs_tensor = torch.tensor(next_obs, dtype=torch.float32).reshape(1, -1).to(model.device)
    state      = model.features(obs_tensor)
    next_state = model.features(next_obs_tensor)
    
    # Detach everything related to the target model
    next_state_target = target_model.features(next_obs_tensor).detach()
    
    # β(s',o) --> Probability of terminating in the next state given the current option
    # Detach because it's part of gt
    next_termination_prob = model.terminations(next_state)[:, option].sigmoid().detach()
    
    # Q(s',o) --> The Q_Omega value in the next state given the current option
    # Use the target network to estimate Q_Omega
    # Detach because it's part of gt and target_model
    next_Q_Omegas_target = target_model.Q(next_state_target).squeeze()[option].detach()
    
    # max_o' Q(s', o') --> The max Q_Omega value in the next state over all options
    # Use the target network to estimate Q_Omega
    # Detach because it's part of gt and target_model
    max_Q_Omegas_target = target_model.Q(next_state_target).squeeze().max(dim=-1)[0].detach()

    # gt = r + γ * [(1 − β(s',o)) * Q(s',o) + β(s',o) * max_o' Q(s', o')]
    # gt = reward + discount * [prob_continue_next_state * curr_option_value_for_next_state + prob_terminate_next_state * max_option_value_for_next_state]
    # Detach gt itself (fixed reference value)
    gt = reward + (1 - done) * model.gamma * ((1 - next_termination_prob) * next_Q_Omegas_target + next_termination_prob * max_Q_Omegas_target).detach()
    
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
    policy_loss = -logp * Q_est_err - model.entropy_reg * entropy
    
    actor_loss = termination_loss + policy_loss
    return actor_loss

def critic_loss():
    pass