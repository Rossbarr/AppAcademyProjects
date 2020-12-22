from piece import Piece

class King(Piece):
    def __init__(self, color, board, pos):
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
        """
        moves = []
        move_diffs = self._move_diffs
        x, y = self.pos
        for move in move_diffs:
            dx, dy = move
            new_pos = [x+dx, y+dy]
            if (dy == -2 or dy == 2):
                if (not self.moved and dy == -2 and
                    not self.board.in_check(self.color) and 
                    not self.board.rows[x, 0].moved and
                    self.board.empty([x, 1]) and
                    self.board.empty([x, 2]) and
                    self.board.empty([x, 3])):
                    moves.append(new_pos)
                elif (not self.moved and dy == 2 and 
                    not self.board.in_check(self.color) and 
                    not self.board.rows[x, 7].moved and
                    self.board.empty([x, 5]) and 
                    self.board.empty([x, 6])):
                    moves.append(new_pos)
            elif (self.board.valid(new_pos) and 
                    (self.board.empty(new_pos) or self.board.rows[x+dx, y+dy].color != self.color)):
                moves.append(new_pos)
        return moves