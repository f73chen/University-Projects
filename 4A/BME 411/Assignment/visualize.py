import numpy as np
import networkx as nx
import matplotlib.pyplot as plt
from matplotlib import colors as mcolors

def get_nodes_and_edges_subway(stations):
    """Convert a list of station/intersection objects into nodes and edges for the graph
    
    :return: nodes, edges of graph
    """
    # Turn node_list into nodes
    nodes = {}
    for name, node in stations.items():
        nodes[name] = (node.x, node.y)
    
    # Turn connections into edges
    edges = []
    for name, node in stations.items():
        for next_node, (line, travel_time) in node.connections.items():
            edges.append((name, next_node.name, {'weight': travel_time, 'line': line.name}))

    return nodes, edges

def get_nodes_and_edges_traffic(intersections):
    """Convert a list of station/intersection objects into nodes and edges for the graph
    
    :return: nodes, edges of graph
    """
    # Turn intersections into nodes
    nodes = {}
    for location, node in intersections.items():
        nodes[node.name] = location
    
    # Turn connections into edges
    edges = []
    for location, node in intersections.items():
        for next_node, weight in node.connections.items():
            edges.append((node.name, next_node.name, {'weight': weight}))

    return nodes, edges

def get_graph(nodes, edges, plot=True, directed=False):
    """Draws a graph of the nodes and edges
    :param plot: boolean value to show plot or not
    
    :return: nx graph object
    """
    plt.figure(figsize=(9, 9))
    
    G = nx.DiGraph() if directed else nx.Graph()

    G.add_nodes_from(nodes.keys())
    G.add_edges_from(edges)
    
    # Visualize the graph with node positions
    plt.figure(3, figsize=(12, 12))
    nx.draw(G, nodes, with_labels=True, node_color='lightblue', node_size=500, font_weight='bold')
    nx.draw_networkx_edges(G, nodes, width=1.0, alpha=0.5)
    nx.draw_networkx_edge_labels(G, nodes, edge_labels={(u, v): d['weight'] for u, v, d in G.edges(data=True)})

    if plot:
        plt.show()

    return G

def draw_graph_path(G, nodes, shortest_path, directed=False):
    """
    :param shortest_path: list of numbers representing the node indices of path
    """
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