import numpy as np
from piece import Piece
import slideable as s

class Rook(Piece):
    moves = s.moves
    grow_unblocked_moves_in_dir = s.grow_unblocked_moves_in_dir

    def symbol(self):
        return "R"

    def _move_dirs(self):
        return np.array(s.ORTHOGONAL_DIRS)
