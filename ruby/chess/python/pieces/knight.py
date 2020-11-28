import numpy as np
from piece import Piece
import stepable as s

class Knight(Piece):
    moves = s.moves

    def symbol(self):
        return "N"

    def _move_diffs(self):
        return np.array([[1, 2], [2, 1], [2, -1], [1, -2], [-1, -2], [-2, -1], [-2, 1], [-1, 2]])
