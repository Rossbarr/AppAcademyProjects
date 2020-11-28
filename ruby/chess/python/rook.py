import numpy as np
import piece
import slideable as s

class Rook(piece.Piece):
    moves = s.moves
    grow_unblocked_moves_in_dir = s.grow_unblocked_moves_in_dir

    def symbol(self):
        return "R"

    def _move_dirs(self):
        return np.array(s.ORTHOGONAL_DIRS)
