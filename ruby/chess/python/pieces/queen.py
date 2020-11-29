from piece import Piece
import slideable as s

class Queen(Piece):
    moves = s.moves
    grow_unblocked_moves_in_dir = s.grow_unblocked_moves_in_dir

    def __init__(self, color, board, pos):
        super().__init__(color, board, pos)
        self.symbol = "Q"

    def _move_dirs(self):
        return s.ORTHOGONAL_DIRS + s.DIAGONAL_DIRS

