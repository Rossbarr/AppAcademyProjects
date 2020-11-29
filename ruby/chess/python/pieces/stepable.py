def moves(piece):
    moves = []
    move_diffs = piece._move_diffs()
    for diff in move_diffs:
        dx, dy = diff
        x, y = piece.pos
        new_pos = [x+dx, y+dy]
        if not piece.board.valid(new_pos):
            continue
        if piece.board.empty(new_pos) or piece.board.rows[x+dx, y+dy].color != piece.color:
            moves.append(new_pos)
    return moves
