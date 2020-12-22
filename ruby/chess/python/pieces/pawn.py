from piece import Piece

class Pawn(Piece):
    def __init__(self, color, board, pos):
        super().__init__(color, board, pos)
        self.symbol = "p"
        self.forward = self.__forward_dir()

    def moves(self):
        """
        Returns a list of the possible forward movements and diagonal attacks
        """
        forwards = self.__forward_steps()
        diags = self.__side_attacks()
        if len(forwards) > 0 and len(diags) > 0:
            result = self.__forward_steps() + self.__side_attacks()
        elif len(forwards) > 0:
            result = forwards
        elif len(diags) > 0:
            result = diags
        else:
            result = []
        return result

    def __forward_dir(self):
        """
        Sets forward direction.
        """
        if self.color == "black":
            forward = 1
        elif self.color == "white":
            forward = -1
        else:
            print("The pawn color is {}".format(self.color))
            raise Exception("Pawn color is not white or black")

        return forward

    def __forward_steps(self):
        """
        Returns a list of forward moves.
        This checks if there's anything blocking the pawn,
        and if it's at the starting row,
        and adjusts the possible moves accordingly.
        """
        x, y = self.pos
        moves = []
        forward = self.forward
        # Check if there's something in front of the pawn
        if self.board.empty([x + forward, y]):
            moves.append([x + forward, y])
            # The next line is intentionally nested
            # as, if there's something immediately in front of the pawn, it is stuck anyway
            if not self.moved and self.board.empty([x + forward + forward, y]):
                moves.append([x + forward + forward, y])

        return moves

    def __side_attacks(self):
        """
        Returns a list of diagonal attacks the pawn can make
        """
        x, y = self.pos
        forward = self.forward
        moves = []
        left = [x + forward, y - 1]
        right = [x + forward, y + 1]
        if self.board.valid(left) and not self.board.empty(left):
            if self.board.rows[x + forward, y - 1].color != self.color:
                moves.append(left)
        if self.board.valid(right) and not self.board.empty(right):
            if self.board.rows[x + forward, y + 1].color != self.color:
                moves.append(right)
        if x == 3 and forward == -1 and self.board.last_move[0].symbol == "p":
            if self.board.last_move[1] == [1, y - 1] and self.board.last_move[2] == [3, y - 1]:
                moves.append(left)
            if self.board.last_move[1] == [1, y + 1] and self.board.last_move[2] == [3, y + 1]:
                moves.append(right)
        elif x == 4 and forward == 1  and self.board.last_move[0].symbol == "p":
            if self.board.last_move[1] == [6, y - 1] and self.board.last_move[2] == [4, y - 1]:
                moves.append(left)
            if self.board.last_move[1] == [6, y + 1] and self.board.last_move[2] == [4, y + 1]:
                moves.append(right)

        return moves
