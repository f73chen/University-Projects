import networkx as nx
import numpy as np
import matplotlib.pyplot as plt
from matplotlib import colors as mcolors

def get_nodes_and_edges(intersections):
    """Draws map of stations based on json file
    
    :return: nodes, edges of graph
    """
    # Turn intersections into nodes
    nodes = {}
    for location, intersection in intersections.items():
        nodes[intersection.name] = location
    
    # Turn roads into edges
    edges = []
    for location, intersection in intersections.items():
        for next_intersection, weight in intersection.connections.items():
            edges.append((intersection.name, next_intersection.name, {'weight': weight}))

    return nodes, edges

def get_graph(intersections, plot=True, directed=False):
    """Draws map of stations based on json file
    :param plot: boolean value to show plot or not
    
    :return: nx graph object
    """
    G = nx.DiGraph() if directed else nx.Graph()

    nodes, edges = get_nodes_and_edges(intersections)

    G.add_nodes_from([intersection.name for intersection in intersections.values()])
    G.add_edges_from(edges)
    
    # Visualize the graph with node positions
    nx.draw(G, nodes, with_labels=True, node_color='lightblue', node_size=500, font_weight='bold')
    nx.draw_networkx_edges(G, nodes, width=1.0, alpha=0.5)
    nx.draw_networkx_edge_labels(G, nodes, edge_labels={(u, v): d['weight'] for u, v, d in G.edges(data=True)})

    if plot:
        plt.show()

    return G

def draw_graph_path(G, intersections, shortest_path, directed=False):
    """
    :param shortest_path: list of numbers representing the node indices of path
    """
    # Visualize the graph with node positions and edge labels
    nodes, _ = get_nodes_and_edges(intersections)
    
    # Convert the colors to their RGBA values
    start_rgba = np.array(mcolors.to_rgba('greenyellow' ))
    target_rgba = np.array(mcolors.to_rgba('salmon'))
    
    # Compute the color for each node based on its position between start and target in the shortest path
    node_colors = [
        mcolors.to_hex(start_rgba + (shortest_path.index(node) / (len(shortest_path) - 1)) * (target_rgba - start_rgba))
        if node in shortest_path else 'lightgray' for node in G.nodes()
    ]

    if directed:
        edge_colors = ['red' if edge in zip(shortest_path, shortest_path[1:]) else 'none' for edge in G.edges()]
    else:
        edge_colors = ['red' if edge in zip(shortest_path, shortest_path[1:]) or edge[::-1] in zip(shortest_path, shortest_path[1:]) else 'black' for edge in G.edges()]
    
    # draw graph
    nx.draw(
        G,
        nodes,
        with_labels=True,
        node_color=node_colors,
        node_size=500,
        font_weight='bold',
        edge_color=edge_colors,
        edgecolors=['black' if node in shortest_path else 'none' for node in G.nodes()],
        linewidths=2.0,
        width=2.0,
        arrows=True
    )
    
    legend_labels = {'Start Node': 'greenyellow', 'Target Node': 'salmon'}
    legend_handles = [plt.Line2D([0], [0], marker='o', color='w', markerfacecolor=color, markersize=10, markeredgewidth=2, markeredgecolor='black', label=label)
                      for label, color in legend_labels.items()]
    
    plt.legend(handles=legend_handles)
    plt.show()