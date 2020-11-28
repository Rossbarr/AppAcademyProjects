import numpy as np
import sys
sys.path.append('pieces/')

from pieces.king import King
from pieces.queen import Queen
from pieces.rook import Rook
from pieces.bishop import Bishop
from pieces.knight import Knight
from pieces.pawn import Pawn
from pieces.piece import NullPiece

class Board():
    def __init__(self):
        self.rows = np.full(shape = (8,8), fill_value = NullPiece())
        for i in range(8):
            for j in range(8):
                if i == 0:
                    color = "black"
                elif i == 1:
                    color = "black"
                    self.rows[i, j] = Pawn(color, self, [i, j])
                    continue
                elif i == 6:
                    color = "white"
                    self.rows[i, j] = Pawn(color, self, [i, j])
                    continue
                elif i == 7:
                    color = "white"
                else:
                    break

                if j == 0 or j == 7:
                    self.rows[i, j] = Rook(color, self, [i, j])
                elif j == 1 or j == 6:
                    self.rows[i, j] = Knight(color, self, [i, j])
                elif j == 2 or j == 5:
                    self.rows[i, j] = Bishop(color, self, [i, j])
                elif j == 3:
                    self.rows[i, j] = Queen(color, self, [i, j])
                elif j == 4:
                    self.rows[i, j] = King(color, self, [i, j])
                else:
                    self.rows[i, j] = Piece(color, self, [i, j])

    def move_piece(self, start_pos, end_pos):
        a, b = start_pos
        x, y = end_pos
        if self.empty(start_pos):
            raise Exception("No piece at start_pos to be moved")
        
        self.rows[x, y] = self.rows[a, b]
        self.rows[a, b] = NullPiece()

    def valid(self, pos):
        x, y = pos[0], pos[1]
        return (0 <= x < 8 and 0 <= y < 8)

    def empty(self, pos):
        return type(self.rows[pos[0], pos[1]]) == type(NullPiece())
