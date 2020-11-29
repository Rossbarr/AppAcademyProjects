from piece import Piece
import slideable as s

class Bishop(Piece):
    moves = s.moves
    grow_unblocked_moves_in_dir = s.grow_unblocked_moves_in_dir

    def __init__(self, color, board, pos):
        super().__init__(color, board, pos)
        self.symbol = "B"

    def _move_dirs(self):
        return s.DIAGONAL_DIRS
