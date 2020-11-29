from piece import Piece
import stepable as s

class Knight(Piece):
    moves = s.moves

    def __init__(self, color, board, pos):
        super().__init__(color, board, pos)
        self.symbol = "N"

    def _move_diffs(self):
        return [[1, 2], [2, 1], [2, -1], [1, -2], [-1, -2], [-2, -1], [-2, 1], [-1, 2]]
