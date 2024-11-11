from maze_env import Maze
import numpy as np
import sys
import matplotlib.pyplot as plt
import pickle
import time
import seaborn as sns
import ast
import warnings
from RL_brainsample_wrong import rlalgorithm as rlalg1 
from RL_brainsample_sarsa import rlalgorithm as rlalg_sarsa
from RL_brainsample_qlearning import rlalgorithm as rlalg_ql
from RL_brainsample_expsarsa import rlalgorithm as rlalg_expsarsa
from RL_brainsample_doubqlearning import rlalgorithm as rlalg_double_ql

DEBUG=0
def debug(debuglevel, msg, **kwargs):
    if debuglevel <= DEBUG:
        if 'printNow' in kwargs:
            if kwargs['printNow']:
                print(msg)
        else:
            print(msg)


def plot_rewards(experiments, window=100):
    """Generate plot of rewards for given experiments list and window controls the length
    of the window of previous episodes to use for average reward calculations.
    """
    plt.figure(2)
    plt.subplot(121)
    window_color_list=['blue','red','green','black','purple']
    color_list=['lightblue','lightcoral','lightgreen', 'darkgrey', 'magenta']
    label_list=[]
    for i, (name, env, RL, data) in enumerate(experiments):
        x_values=range(len(data['global_reward']))
        label_list.append(RL.display_name)
        y_values=data['global_reward']
        plt.plot(x_values, y_values, c=color_list[i],label=label_list[-1])
        plt.legend(label_list)
    if len(x_values) >= window : 
        for i, (name, env, RL, data) in enumerate(experiments):
            x_values=range(window, 
                    len(data['med_rew_window'])+window)
            y_values=data['med_rew_window']
            plt.plot(x_values, y_values,
                    c=window_color_list[i])
    plt.title("Summed Reward", fontsize=16)
    plt.xlabel("Episode", fontsize=16)
    plt.ylabel("Reward", fontsize=16)
    plt.tick_params(axis='both', which='major',
                    labelsize=14)
    # plt.show()

def plot_length(experiments):
    plt.figure(2)
    plt.subplot(122)
    color_list=['blue','green','red','black','magenta']
    label_list=[]
    for i, (name, env, RL, data) in enumerate(experiments):
        x_values=range(len(data['ep_length']))
        label_list.append(RL.display_name)
        y_values=data['ep_length']
        plt.plot(x_values, y_values, c=color_list[i],label=label_list[-1])
        plt.legend(label_list)
    plt.title("Path Length", fontsize=16)
    plt.xlabel("Episode", fontsize=16)
    plt.ylabel("Length", fontsize=16)
    plt.tick_params(axis='both', which='major',
                    labelsize=14)
    # plt.show()

# New: Average computation time per episode for each algorithm
def plot_computation_time(experiments):
    plt.figure()
    for i, (name, env, RL, data) in enumerate(experiments):
        x_values = range(len(data['computation_time']))
        y_values = data['computation_time']
        plt.plot(x_values, y_values, label=RL.display_name)
        
    plt.title("Average Computation Time per Episode")
    plt.xlabel("Episode", fontsize=16)
    plt.ylabel("Computation Time (seconds)", fontsize=16)
    plt.legend()
    plt.show()

# New: Histogram of cumulative rewards over the last 200 episodes for each algorithm
def plot_reward_distribution(experiments, last_n=200):
    plt.figure(figsize=(15, 5))

    # To make all graphs the same scale, find the global min/max rewards in the last n episodes across all experiments
    all_rewards = []
    for _, _, _, data in experiments:
        all_rewards.extend(data['global_reward'][-last_n:])
    global_min = min(all_rewards)
    global_max = max(all_rewards)
    bins = 20

    # Find the maximum frequency across all experiments
    max_frequency = 0
    for _, _, _, data in experiments:
        hist, _ = np.histogram(data['global_reward'][-last_n:], bins=bins, range=(global_min, global_max))
        max_frequency = max(max_frequency, max(hist))

    # Draw the subplots
    for i, (name, env, RL, data) in enumerate(experiments):
        plt.subplot(1, len(experiments), i + 1)
        rewards = data['global_reward'][-last_n:]
        plt.hist(rewards, bins=bins, range=(global_min, global_max), color='lightblue', edgecolor='black')
        plt.title(f"{RL.display_name} Reward Distribution")
        plt.xlabel("Reward")
        plt.ylabel("Frequency")

        # Adjust the x and y ranges
        plt.xlim(global_min, global_max)
        plt.ylim(0, max_frequency)
        plt.tight_layout()
    
    plt.show()

# New: Heatmap of the max Q-value at each state after training
def plot_state_value_heatmaps(experiments):
    maze_height = 10
    maze_width = 10

    # Create a new figure with a 2-row, 3-column layout
    fig, axes = plt.subplots(2, 3, figsize=(18, 10))
    fig.suptitle("State Value Heatmaps", fontsize=20)

    # Record subplot positions for each algorithm
    subplot_mapping = {
        "SARSA": (0, 0),
        "Expected SARSA": (0, 1),
        "Q-Learning": (0, 2),
        "Double Q-Learning Q1": (1, 0),
        "Double Q-Learning Q2": (1, 1),
        "Double Q-Learning Q1 + Q2": (1, 2),
    }
    
    # Helper function to plot a single heatmap
    def plot_heatmap(grid, ax, title):
        sns.heatmap(grid, cmap='viridis', annot=False, cbar=True, ax=ax)
        ax.set_title(title, fontsize=14)
        ax.set_xlabel("Grid X")
        ax.set_ylabel("Grid Y")
        
    # Helper function to convert canvas coordinates back to simple x-y grids
    def coordinates_to_grid(state, cell_width=40, cell_height=40):
        state = ast.literal_eval(state)
        left, top, _, _ = state
        x_idx = int(left / cell_width)
        y_idx = int(top / cell_height)
        return x_idx, y_idx

    # Plot each algorithm
    for name, env, RL, _ in experiments:
        if RL.display_name == "Double Q-Learning":
            # Create three heatmaps: Q1, Q2, and max(Q1, Q2)
            q1_values = {state: np.max(q_values) for state, q_values in RL.Q1.items()}
            q2_values = {state: np.max(q_values) for state, q_values in RL.Q2.items()}
            max_values = {state: np.max(RL.Q1[state] + RL.Q2[state]) for state in RL.Q1}

            # Prepare state value grids
            grids = { "Double Q-Learning Q1": np.zeros((maze_height, maze_width)),
                      "Double Q-Learning Q2": np.zeros((maze_height, maze_width)),
                      "Double Q-Learning Q1 + Q2": np.zeros((maze_height, maze_width)) }

            for state, value in q1_values.items():
                x, y = coordinates_to_grid(state)
                grids["Double Q-Learning Q1"][y, x] = value
            for state, value in q2_values.items():
                x, y = coordinates_to_grid(state)
                grids["Double Q-Learning Q2"][y, x] = value
            for state, value in max_values.items():
                x, y = coordinates_to_grid(state)
                grids["Double Q-Learning Q1 + Q2"][y, x] = value

            # Plot each heatmap
            for title, grid in grids.items():
                row, col = subplot_mapping[title]
                plot_heatmap(grid, axes[row, col], title)

        else:
            # For other algorithms, use self.Q instead of Q1, Q2
            state_values = {state: np.max(q_values) for state, q_values in RL.Q.items()}
            value_grid = np.zeros((maze_height, maze_width))
            for state, value in state_values.items():
                x, y = coordinates_to_grid(state)
                value_grid[y][x] = value

            row, col = subplot_mapping[RL.display_name]
            plot_heatmap(value_grid, axes[row, col], RL.display_name)

    plt.tight_layout()
    plt.subplots_adjust(top=0.88)
    plt.show()


def update(env, RL, data, episodes=50, window=100, **kwargs):
    global_reward = np.zeros(episodes)
    data['global_reward']=global_reward
    ep_length = np.zeros(episodes)
    data['ep_length']=ep_length
    if episodes >= window:
        med_rew_window = np.zeros(episodes-window)
        var_rew_window = np.zeros(episodes)
    else:
        med_rew_window = []
        var_rew_window = []
    data['med_rew_window'] = med_rew_window
    data['var_rew_window'] = var_rew_window
    
    # Custom metrics
    computation_time = np.zeros(episodes)
    data['computation_time'] = computation_time
    total_start_time = time.time()

    for episode in range(episodes):  
        t=0
        start_time = time.time()
        ''' initial state
            Note: the state is represented as two pairs of 
            coordinates, for the bottom left corner and the 
            top right corner of the agent square.
        '''
        if episode == 0:
            state = env.reset(value = 0)
        else:
            state = env.reset()

        debug(2,'state(ep:{},t:{})={}'.format(episode, t, state))

        if(showRender and (episode % renderEveryNth)==0):
            print('Rendering Now Alg:{} Ep:{}/{} at speed:{}'.format(RL.display_name, episode, episodes, sim_speed))

        # The main loop of the training on an episode
        # RL choose action based on state
        action = RL.choose_action(str(state))

        while True:
            # fresh env
            if(showRender and (episode % renderEveryNth)==0):
                print("rendering")
                env.render(sim_speed)

            # RL take action and get next state and reward
            state_, reward, done = env.step(action)
            global_reward[episode] += reward
            debug(2,'state(ep:{},t:{})={}'.format(episode, t, state))
            debug(2,'reward={:.3f} return_t={:.3f} Mean50={:.3f}'.format(reward, global_reward[episode],np.mean(global_reward[-50:])))

            # RL learn from this transition
            # and determine next state and action
            state, action =  RL.learn(str(state), action, reward, str(state_))

            # break while loop when end of this episode
            if done:
                break
            else:
                t=t+1

        debug(1,"({}) Ep {} Length={} Summed Reward={:.3} ".format(RL.display_name,episode, t,  global_reward[episode],global_reward[episode]),printNow=(episode%printEveryNth==0))

        #save data about length of the episode
        ep_length[episode]=t

        if(episode>=window):
            med_rew_window[episode-window] = np.median(global_reward[episode-window:episode])
            var_rew_window[episode-window] = np.var(global_reward[episode-window:episode])
            debug(1,"    Med-{}={:.3f} Var-{}={:.3f}".format(
                    window,
                    med_rew_window[episode-window],
                    window,
                    var_rew_window[episode-window]),
                printNow=(episode%printEveryNth==0))
        
        computation_time[episode] = time.time() - start_time
            
    data['total_training_time'] = time.time() - total_start_time
            
    print('Algorithm {} completed'.format(RL.display_name))
    env.destroy()

if __name__ == "__main__":
    warnings.filterwarnings("ignore")
    #sim_speed of .1 is nice to view, .001 is fast but visible, sim_speed has not effect if showRender is False
    sim_speed = 0.001 #.001

    #Which task to run, select just one
    usetask = 3 # 1,2,3

    #Example Full Run, you may need to run longer
    showRender=False
    episodes=400
    renderEveryNth=10000
    printEveryNth=10000
    window=10
    do_plot_rewards=True
    do_plot_length=True

    if(len(sys.argv)>1):
        episodes = int(sys.argv[1])
    if(len(sys.argv)>2):
        showRender = sys.argv[2] in ['true','True','T','t']
    if(len(sys.argv)>3):
        datafile = sys.argv[3]


    # Task Specifications
    # point [0,0] is the top left corner
    # point [x,y] is x columns over and y rows down
    # range of x and y is [0,9]
    # agentXY=[0,0] # Agent start position [column, row]
    # goalXY=[4,4] # Target position, terminal state

    #Task 1
    if usetask == 1:
        agentXY=[1,6] # Agent start position
        goalXY=[8,1] # Target position, terminal state
        wall_shape=np.array([[2,6], [2,5], [2,4], [6,1],[6,2],[6,3]])
        pits=np.array([[9,1],[8,3], [0,9]])

    #Task 2 - cliff face
    if usetask == 2:
        agentXY=[0,2] # Agent start position
        goalXY=[2,6] # Target position, terminal state
        wall_shape=np.array([ [0,3], [0,4], [0,5], [0,6], [0,7], [0,1],[1,1],[2,1],[8,7],[8,5],[8,3],[2,7]])
        pits=np.array([[1,3], [1,4], [1,5], [1,6], [1,7], [2,5],[8,6],[8,4],[8,2]])


    #Task 3
    if usetask == 3:
        agentXY=[3,1] # Agent start position
        goalXY=[3,8] # Target position, terminal state
        wall_shape=np.array([[1,2],[1,3],[2,3],[4,3],[7,4],[3,6],[3,7],[2,7]])
        pits=np.array([[2,2],[3,4],[5,2],[0,5],[7,5],[0,6],[8,6],[0,7],[4,7],[2,8]])
    experiments=[]



    name2 = "SARSA on Task " + str(usetask)
    env2 = Maze(agentXY, goalXY, wall_shape, pits, showRender=showRender, name=name2)
    RL2 = rlalg_sarsa(actions=list(range(env2.n_actions)))
    data2 = {}
    env2.after(10, update(env2, RL2, data2, episodes, window))
    env2.mainloop()
    experiments.append((name2, env2, RL2, data2))
    
    name3 = "Q-Learning on Task " + str(usetask)
    env3 = Maze(agentXY, goalXY, wall_shape, pits, showRender=showRender, name=name3)
    RL3 = rlalg_ql(actions=list(range(env3.n_actions)))
    data3 = {}
    env3.after(10, update(env3, RL3, data3, episodes, window))
    env3.mainloop()
    experiments.append((name3, env3, RL3, data3))
    
    name4 = "Expected SARSA on Task " + str(usetask)
    env4 = Maze(agentXY, goalXY, wall_shape, pits, showRender=showRender, name=name4)
    RL4 = rlalg_expsarsa(actions=list(range(env4.n_actions)))
    data4 = {}
    env4.after(10, update(env4, RL4, data4, episodes, window))
    env4.mainloop()
    experiments.append((name4, env4, RL4, data4))
    
    name5 = "Double Q-Learning on Task " + str(usetask)
    env5 = Maze(agentXY, goalXY, wall_shape, pits, showRender=showRender, name=name5)
    RL5 = rlalg_double_ql(actions=list(range(env5.n_actions)))
    data5 = {}
    env5.after(10, update(env5, RL5, data5, episodes, window))
    env5.mainloop()
    experiments.append((name5, env5, RL5, data5))


    print("All experiments complete")

    print(f"Experiment Setup:\n - episodes:{episodes}\n - sim_speed:{sim_speed}\n") 

    for name, env, RL, data in experiments:
        print("[{}] : {} : max-rew={:.3f} med-{}={:.3f} var-{}={:.3f} max-episode-len={}".format(
            name, 
            RL.display_name, 
            np.max(data['global_reward']),
            window,
            np.median(data['global_reward'][-window:]), 
            window,
            np.var(data['global_reward'][-window:]),
            np.max(data['ep_length'])))


    if(do_plot_rewards):
        plot_rewards(experiments, window)

    if(do_plot_length):
        plot_length(experiments)
    
    if do_plot_rewards or do_plot_length:
        plt.show()
        
    plot_computation_time(experiments)
    plot_reward_distribution(experiments)
    plot_state_value_heatmaps(experiments)
        

