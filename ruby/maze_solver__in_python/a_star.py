import matplotlib.pyplot as plt
from node import Node

class AStar():
    def __init__(self, maze_file):
        self.maze = self.read_in_maze_file(maze_file)
        self.open = [] # starts with the starting square inside it
        self.closed = []
        self.start, self.end = self.find_start_and_end()

    def solve(self):
        self.open.append(Node(self.start, self.end))  # Add the starting node to the open list
        done = False
        while not done:
            curr_node = self.find_min_cost_node()
            positions = curr_node.find_adjacent_positions()
            positions = self.filter_positions(positions)
            positions = self.check_if_in_open(positions, curr_node)
            for pos in positions:
                self.open.append(Node(pos, self.end, curr_node)) 
            if len(self.open) == 0:
                print("failed!")
                done = True
            for node in self.closed:
                if list(node.pos) == self.end:
                    print("found the end!")
                    done = True
                    self.create_path()
                    break

    def create_path(self):
        path = []
        node = self.closed[-1]
        while True:
            path.append(node.pos)
            if node.pos == a.start:
                break
            node = node.parent
        print("My path is : ")
        path.reverse()
        print(path)
        
    def read_in_maze_file(self, maze_file):
        arr = []
        f = open("maze_1.txt", "r")
        for line in f:
            aline = [0]*len(line.rstrip('\n'))
            i = 0
            for char in line.rstrip('\n'):
                aline[i] = char
                i += 1
            arr.append(aline)
        f.close()
        return arr

    def find_start_and_end(self):
        for x in range(len(self.maze)):
            for y in range(len(self.maze[0])):
                if self.maze[x][y] == "E":
                    end = [x, y]
                elif self.maze[x][y] == "S":
                    start = [x, y]
        return start, end

    def filter_positions(self, positions):
        """
        This method filters the adjacent positions of the current node.
        It removes positions that are walls or nodes on the closed list.
        """
        for node in self.closed:
            for pos in positions:
                x, y = pos
                if self.maze[x][y] == "*":
                    positions.remove(pos)
                elif node.pos == pos:
                    positions.remove(pos)
        return positions
 
    def find_min_cost_node(self):
        """
        This method finds the lowest cost node in the open array.
        It then adds that node to the closed list and removes it from the open list.
        The first two lines simply set up the variables to be used.
        """
        cost = self.open[0].f
        curr_node = self.open[0]
        for node in self.open:
            if node.f < cost:
                cost = node.f
                curr_node = node
        self.closed.append(curr_node)
        self.open.remove(curr_node)
        return curr_node
 
    def check_if_in_open(self, positions, curr_node):
        """
        This method checks if an adjacent position is a node in the open list.
        If it is, the position is removed from the list (so it's not re-added to the open list).
        The method goes on to check if the path from this node is more efficient than it's current parent node.
        If the new path is more efficient, the parent of that node is replaced with the current node.
        """
        for node in self.open:
            for pos in positions:
                x, y = pos
                if node.pos == pos:
                    positions.remove(pos)
                    if node.calculate_g(curr_node) < node.g:
                        node.parent = curr_node
                        node.set_f_g_h(self.end, curr_node)
        return positions


a = AStar("maze_1.txt")
a.solve()
