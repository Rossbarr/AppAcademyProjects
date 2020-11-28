class Piece():
    def __init__(self, color, board, pos):
        self.color = color
        self.board = board
        self.pos = pos

    def valid_moves(self):
        return True

class NullPiece(Piece):
    def __init__(self):
        pass
