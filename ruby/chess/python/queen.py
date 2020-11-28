import numpy as np
import piece
import slideable as s

class Queen(piece.Piece):
    moves = s.moves
    grow_unblocked_moves_in_dir = s.grow_unblocked_moves_in_dir

    def symbol(self):
        return "Q"

    def _move_dirs(self):
        return np.concatenate((s.ORTHOGONAL_DIRS, s.DIAGONAL_DIRS))

