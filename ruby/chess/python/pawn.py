import numpy as np
import piece

class Pawn(piece.Piece):
    def symbol(self):
        return "p"

    def moves(self):
        """
        Returns a numpy array of the possible forward movements and diagonal attacks
        """
        forwards = self.__forward_steps()
        diags = self.__side_attacks()
        if len(forwards) > 0 and len(diags) > 0:
            result = np.concatenate((self.__forward_steps(), self.__side_attacks()))
        elif len(forwards) > 0:
            result = np.array(forwards)
        elif len(diags) > 0:
            result = np.array(diags)
        else:
            result = np.array([])
        return result

    def __at_start_row(self):
        start_row = 8
        if self.color == "black":
            start_row = 1
        elif self.color == "white":
            start_row = 6
        else:
            print("The pawn color is {}".format(self.color))
            raise StandardError("Pawn color is not white or black")
        
        return True if (self.pos[0] == start_row) else False

    def __forward_dir(self):
        if self.color == "black":
            forward = 1
        elif self.color == "white":
            forward = -1
        else:
            print("The pawn color is {}".format(self.color))
            raise StandardError("Pawn color is not white or black")

        return forward

    def __forward_steps(self):
        x, y = self.pos
        moves = []
        forward = self.__forward_dir()
        # Check if there's something in front of the pawn
        if self.board.empty([x + forward, y]):
            moves.append([x + forward, y])
            # The next line is intentionally nested
            # If there's something immediately in front of the pawn, it is stuck
            if self.__at_start_row() and self.board.empty([x + forward + forward, y]):
                moves.append([x + forward + forward, y])
        
        return moves

    def __side_attacks(self):
        x, y = self.pos
        forward = self.__forward_dir()
        moves = []
        left = [x + forward, y - 1]
        right = [x + forward, y + 1]
        if not self.board.empty(left):
            if self.board[x + forward, y - 1].color != self.color:
                moves.append(left)
        if not self.board.empty(right):
            if self.board[x + forward, y + 1].color != self.color:
                moves.append(right)

        return moves
