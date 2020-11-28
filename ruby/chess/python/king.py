import numpy as np
import piece
import stepable as s

class King(piece.Piece):
    moves = s.moves

    def symbol(self):
        return "K"

    def _move_diffs(self):
        return np.array([[0, 1], [1, 1], [1, 0], [1, -1], [0, -1], [-1, -1], [-1, 0], [-1, 1]])
