class Node():
    def __init__(self, pos, end, parent = None):
        self.pos = pos
        self.parent = parent
        self.set_f_g_h(end, parent)

    def find_adjacent_positions(self):
        x, y = self.pos
        positions = [[x+1, y], [x+1, y+1], [x, y+1], [x-1, y+1], [x-1, y], [x-1, y-1], [x, y-1], [x+1, y-1]]
        return positions

    def calculate_f(self, end):
        return self.calculate_g(self.parent) + self.calculate_h(end)

    def calculate_g(self, parent):
        if parent == None:
            return 0

        x, y = self.pos
        xp, yp = parent.pos
        if (abs(xp - x) + abs(yp - y)) == 2:
            g = 14
        elif (abs(xp - x) + abs(yp - y)) == 1:
            g = 10
        else:
            return float('inf')
        return g + parent.g

    def calculate_h(self, end):
        """
        calculates the 'heuristic' which serves as a rough estimate of the remaining distance between the current node and the endpoint.
        """
        x, y = self.pos
        xe, ye = end
        return (abs(xe - x) + abs(ye - y))*10

    def set_f_g_h(self, end, parent):
        self.g = self.calculate_g(parent)
        self.h = self.calculate_h(end)
        self.f = self.g + self.h
