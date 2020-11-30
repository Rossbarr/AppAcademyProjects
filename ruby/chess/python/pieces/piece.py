class Piece():
    def __init__(self, color, board, pos):
        self.color = color
        self.board = board
        self.pos = pos

    def valid_moves(self):
        possible_moves = self.moves()
        allowed_moves = []
        for move in possible_moves:
            if not self.__moves_into_check(move):
                allowed_moves.append(move)
        return allowed_moves

    def __moves_into_check(self, end_pos):
        test_board = self.board.deepcopy()
        test_board._execute_move(self.color, self.pos, end_pos)
        result = test_board.in_check(self.color)
        if result:
            print("{} moves into check".format(end_pos))
        return result

class NullPiece(Piece):
    def __init__(self):
        pass
