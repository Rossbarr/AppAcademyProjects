import numpy as np
from piece import Piece
import slideable as s

class Bishop(Piece):
    moves = s.moves
    grow_unblocked_moves_in_dir = s.grow_unblocked_moves_in_dir

    def symbol(self):
        return "B"

    def _move_dirs(self):
        return np.array(s.DIAGONAL_DIRS)
