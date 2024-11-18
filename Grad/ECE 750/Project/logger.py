import os
import numpy as np
from torch.utils.tensorboard import SummaryWriter

class OCLogger:
    def __init__(self, logdir, run_name):
        self.log_name = logdir + '/' + run_name
        
        if not os.path.exists(self.log_name):
            os.makedirs(self.log_name)
            
        self.writer = SummaryWriter(self.log_name)
        
    def log_step(self, step, actor_loss, critic_loss, entropy, epsilon):
        if actor_loss:
            self.writer.add_scalar(tag="actor_loss", scalar_value=actor_loss.item(), global_step=step)
        if critic_loss:
            self.writer.add_scalar(tag="critic_loss", scalar_value=critic_loss.item(), global_step=step)
        self.writer.add_scalar(tag="entropy", scalar_value=entropy, global_step=step)
        self.writer.add_scalar(tag="epsilon", scalar_value=epsilon, global_step=step)
    
    def log_episode(self, ep_idx, ep_reward, ep_length, option_lengths):
        self.writer.add_scalar(tag="episodic_rewards", scalar_value=ep_reward, global_step=ep_idx)
        self.writer.add_scalar(tag="episode_lengths", scalar_value=ep_length, global_step=ep_idx)
        
        # TODO: Create better option metrics
        for option, lengths in option_lengths.items():
            self.writer.add_scalar(tag=f"option_{option}_avg_length", scalar_value=np.mean(lengths) if lengths else 0, global_step=ep_idx)
            self.writer.add_scalar(tag=f"option_{option}_active_time", scalar_value=sum(lengths)/ep_length, global_step=ep_idx)
        
class AOCLogger(OCLogger):
    def log_step(self):
        pass
    
    def log_episode(self):
        pass
        
if __name__ == "__main__":
    logger = OCLogger(logdir="results/highway_oc", run_name="Test")
    
    # logger.log_step(1, 2, 3, 4, 0.5)
    # logger.log_step(2, 3, 5, 8, 0.9)
    logger.log_episode(0, 10, 100, {0: [1, 4, 2], 1: [6, 4], 2:[]})
    logger.log_episode(1, 20, 50, {0: [2, 2], 1: [], 2:[7, 5]})