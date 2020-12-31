from piece import Piece

class King(Piece):
    """
    King inherits from Piece
    """

    def __init__(self, color, board, pos):
        """
        When a King is initialized, it needs 6 attributes.
        4 of them are defined in the piece parent class,
        and they are shared among all pieces.

        Symbol is another common attribute among pieces.
        It's a quick way for something to get the type of piece it's referencing.

        _move_diffs defines the movement options for the King.
        """
        super().__init__(color, board, pos)
        self.symbol = "K"
        self._move_diffs = [[0, 1], [1, 1], [1, 0], [1, -1], [0, -1], [-1, -1], [-1, 0], [-1, 1], 
                            [0, 2], [0, -2]]

    def moves(self):
        """
        This methods gets the possible movement options from _move_diffs.
        It then checks if those moves are allowed:
        It checks if the new position is valid (on the board) and
        if the position is empty or contains an enemy piece.
        If so, then it adds that move to an array of possible moves.

        The return value is an array of possible movement locations.

        You'll notice that the castling checks take up a lot of space,
        and that's because castling is hard move to implement.
        A lot of things must be true, otherwise you cannot castle.
        """
        moves = []
        move_diffs = self._move_diffs
        x, y = self.pos
        for move in move_diffs:
            dx, dy = move
            new_pos = [x+dx, y+dy]
            if (dy == -2 or dy == 2):   # Castling
                if (dy == -2 and not self.moved and 
                    not self.board.in_check(self.color) and 
                    not self.board.rows[x, 0].moved and
                    self.board.empty([x, 1]) and
                    self.board.empty([x, 2]) and
                    self.board.empty([x, 3])):
                    moves.append(new_pos)
                elif (dy == 2 and not self.moved and 
                    not self.board.in_check(self.color) and 
                    not self.board.rows[x, 7].moved and
                    self.board.empty([x, 5]) and 
                    self.board.empty([x, 6])):
                    moves.append(new_pos)
            elif (self.board.valid(new_pos) and 
                    (self.board.empty(new_pos) or self.board.rows[x+dx, y+dy].color != self.color)):
                moves.append(new_pos)
        return moves