import board

class Display:
    def __init__(self, board):
        self.board = board

    def render(self):
        for i in range(8):
            for j in range(8):
                if self.board.rows[i][j] is not self.board.nothing:
                    print("{}".format(self.board.rows[i][j].symbol), end = " ")
                else:
                    print(" ", end = " ")
            print("\n")
