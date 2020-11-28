import numpy as np
from piece import Piece
import stepable as s

class King(Piece):
    moves = s.moves

    def symbol(self):
        return "K"

    def _move_diffs(self):
        return np.array([[0, 1], [1, 1], [1, 0], [1, -1], [0, -1], [-1, -1], [-1, 0], [-1, 1]])
