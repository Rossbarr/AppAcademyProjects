from piece import Piece

class Knight(Piece):
    """
    Knight inherits from Piece.
    """

    def __init__(self, color, board, pos):
        """
        When a Knight is initialized, it needs 6 attributes.
        4 of them are defined in the piece parent class,
        and they are shared among all pieces.

        Symbol is another common attribute among pieces.
        It's a quick way for something to get the type of piece it's referencing.

        _move_diffs defines the movement options for the Knight.
        """
        super().__init__(color, board, pos)
        self.symbol = "N"
        self._move_diffs = [[1, 2], [2, 1], [2, -1], [1, -2], [-1, -2], [-2, -1], [-2, 1], [-1, 2]]

    def moves(self):
        """
        This methods gets the possible movement options from _move_diffs.
        It then checks if those moves are allowed:
        It checks if the new position is valid (on the board) and
        if the position is empty or contains an enemy piece.
        If so, then it adds that move to an array of possible moves.

        The return value is an array of possible movement locations.
        """
        moves = []
        move_diffs = self._move_diffs
        x, y = self.pos
        for move in move_diffs:
            dx, dy = move
            new_pos = [x+dx, y+dy]
            if self.board.valid(new_pos) and (self.board.empty(new_pos) or self.board.rows[x+dx, y+dy].color != self.color):
                moves.append(new_pos)
        return moves