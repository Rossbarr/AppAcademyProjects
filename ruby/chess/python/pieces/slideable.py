ORTHOGONAL_DIRS = [[1, 0], [-1, 0], [0, 1], [0, -1]]
DIAGONAL_DIRS = [[1, 1], [-1, -1], [1, -1], [-1, 1]]

def moves(piece):
    moves = []
    possible_dirs = piece._move_dirs()
    for direction in possible_dirs:
        for move in piece.grow_unblocked_moves_in_dir(direction):
            moves.append(move)
    return moves

def grow_unblocked_moves_in_dir(piece, direction):
    x, y = piece.pos
    dx, dy = direction
    moves = []
    new_pos = [x+dx, y+dy]
    while piece.board.valid(new_pos):
        if piece.board.empty(new_pos):
            moves.append(new_pos)
        elif piece.board.rows[new_pos[0], new_pos[1]].color != piece.color:
            moves.append(new_pos)
            break
        x, y = new_pos
        new_pos = [x+dx, y+dy]
    return moves
