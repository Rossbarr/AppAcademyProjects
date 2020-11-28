import numpy as np
from piece import Piece
import slideable as s

class Queen(Piece):
    moves = s.moves
    grow_unblocked_moves_in_dir = s.grow_unblocked_moves_in_dir

    def symbol(self):
        return "Q"

    def _move_dirs(self):
        return np.concatenate((s.ORTHOGONAL_DIRS, s.DIAGONAL_DIRS))

