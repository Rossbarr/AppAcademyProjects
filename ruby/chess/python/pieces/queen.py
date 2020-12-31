from piece import Piece
import slideable as s

class Queen(Piece):
    moves = s.moves
    grow_unblocked_moves_in_dir = s.grow_unblocked_moves_in_dir
    """
    Queen inherits from Piece
    and, more importantly, it requires a few things from slideable.

    It sets two of slideable's methods as its own: 
        moves() and grow_unblocked_moves_in_dir()
    """

    def __init__(self, color, board, pos):
        """
        When a Queen is initialized, it needs 6 attributes.
        4 of them are defined in the piece parent class,
        and they are shared among all pieces.

        Symbol is another common attribute among pieces.
        It's a quick way for something to get the type of piece it's referencing.

        Lastly, _move_dirs sets the movement directions of the Queen.
        Since Queens can move orthogonally and diagonally, we use both.
        """
        super().__init__(color, board, pos)
        self.symbol = "Q"
        self._move_dirs = s.ORTHOGONAL_DIRS + s.DIAGONAL_DIRS

