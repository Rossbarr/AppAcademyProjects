import numpy as np
import piece
import slideable as s

class Bishop(piece.Piece):
    moves = s.moves
    grow_unblocked_moves_in_dir = s.grow_unblocked_moves_in_dir

    def symbol(self):
        return "B"

    def _move_dirs(self):
        return np.array(s.DIAGONAL_DIRS)
