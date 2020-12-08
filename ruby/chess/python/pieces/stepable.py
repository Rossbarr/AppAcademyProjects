"""
This moduel is imported into pieces which "step."
In this case, it will be imported into knight and king.

Although you could argue that pawns step,
pawns get special treatment, because they behave so uniquely.
"""

def moves(self):
    """
    This methods gets the possible movement options a piece has from _move_diffs.
    It's hard to explain, but it's essentially all the ways a piece can move.
    This method then sees whether the new locations a piece is trying to move to is allowed.
    It sees if the new position is valid (on the board)
    If it is valid, then it checks to see if the position is empty or contains an enemy piece.
    If so, then it adds that piece to the array of possible moves.

    The return value is an array of possible movement locations.
    """
    moves = []
    move_diffs = self._move_diffs
    x, y = self.pos
    for diff in move_diffs:
        dx, dy = diff
        new_pos = [x+dx, y+dy]
        if self.board.valid(new_pos) and (self.board.empty(new_pos) or self.board.rows[x+dx, y+dy].color != self.color):
            moves.append(new_pos)
    return moves
