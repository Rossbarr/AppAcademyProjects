from piece import Piece
import stepable as s

class King(Piece):
    moves = s.moves

    def __init__(self, color, board, pos):
        super().__init__(color, board, pos)
        self.symbol = "K"

    def _move_diffs(self):
        return [[0, 1], [1, 1], [1, 0], [1, -1], [0, -1], [-1, -1], [-1, 0], [-1, 1]]
