from piece import Piece

class Pawn(Piece):
    """
    Pawn inherits from Piece.
    """

    def __init__(self, color, board, pos):
        """
        When a Pawn is initialized, it needs 6 attributes.
        4 of them are defined in the piece parent class,
        and they are shared among all pieces.

        Symbol is another common attribute among pieces.
        It's a quick way for something to get the type of piece it's referencing.

        forward is the forward direction the Pawn moves, see __forward_dir().
        """
        super().__init__(color, board, pos)
        self.symbol = "p"
        self.forward = self.__forward_dir()

    def moves(self):
        """
        Returns a list of the possible forward movements and diagonal attacks
        given the current positioning of the Pawn and nearby pieces.
        """
        forwards = self.__forward_steps()
        diags = self.__side_attacks()
        
        result = forwards + diags
        
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
            print("The Pawn color is {}".format(self.color))
            raise Exception("Pawn color is not white or black")

        return forward

    def __forward_steps(self):
        """
        Returns a list of forward moves.
        This checks if there's anything blocking the Pawn,
        and if it's at the starting row,
        and adjusts the possible moves accordingly.
        """
        x, y = self.pos
        moves = []
        forward = self.forward
        # Check if there's something in front of the Pawn
        if self.board.empty([x + forward, y]):
            moves.append([x + forward, y])
            # The next line is intentionally nested
            # as, if there's something immediately in front of the Pawn, it is stuck anyway
            if not self.moved and self.board.empty([x + forward + forward, y]):
                moves.append([x + forward + forward, y])

        return moves

    def __side_attacks(self):
        """
        Returns a list of diagonal attacks the Pawn can make
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
