"""
This module is to be imported into pieces which "slide."
In this case, it will be imported into queen, rook, and bishop.

The king isn't a slideable piece because it is limited to moving 1 square.
Slideable pieces can move indefinitly along an empty line.

The pieces themselves dictate whether they can move orthogonoally, diagonally, or both.
They do this by asking for the constants defined immediately below.
"""

ORTHOGONAL_DIRS = [[1, 0], [-1, 0], [0, 1], [0, -1]]
DIAGONAL_DIRS = [[1, 1], [-1, -1], [1, -1], [-1, 1]]

def moves(self):
    """
    This method generates an array of possible movement locations.
    The possible directions a piece can go is retrieved from the _move_dirs attribute,
    which, depending on the piece, contains ORTHOGONAL_DIRS and/or DIAGONAL_DIRS.

    It then steps along this direction until it is somehow blocked,
    (see grow_unblocked_moves_in_dir(direction))
    appending as long as it can move.

    The return value is an array of possible movement locations.
    """
    moves = []
    possible_dirs = self._move_dirs
    for direction in possible_dirs:
        for move in self.grow_unblocked_moves_in_dir(direction):
            moves.append(move)
    return moves

def grow_unblocked_moves_in_dir(self, direction):
    """
    Taking a direction from moves(),
    this method steps along a direction until it finds
        1. the new position is invalid (i.e. off the board)
            The stepping immediately breaks and returns
        2. the new position contains an enemy piece
            The stepping adds the enemy piece location to it's array and returns
        3. the new position contains a friendly piece
            The stepping immediately breaks and returns
    Until one of these 3 things is met, it will add the position to it's list.

    The return value is an array of possible movement locations along a direction.    
    """
    x, y = self.pos
    dx, dy = direction
    moves = []
    new_pos = [x+dx, y+dy]
    while self.board.valid(new_pos):
        if self.board.empty(new_pos):
            moves.append(new_pos)
        elif self.board.rows[new_pos[0], new_pos[1]].color != self.color:
            moves.append(new_pos)
            break
        elif self.board.rows[new_pos[0], new_pos[1]].color == self.color:
            break
        x, y = new_pos
        new_pos = [x+dx, y+dy]
    return moves
