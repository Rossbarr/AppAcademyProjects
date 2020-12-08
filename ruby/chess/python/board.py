import numpy as np
import sys
sys.path.append('pieces/')
from copy import deepcopy

from pieces.king import King
from pieces.queen import Queen
from pieces.rook import Rook
from pieces.bishop import Bishop
from pieces.knight import Knight
from pieces.pawn import Pawn
from pieces.piece import NullPiece

class Board():
    deepcopy = deepcopy

    def __init__(self):
        self.nothing = NullPiece()
        self.rows = np.full(shape = (8,8), fill_value = self.nothing)
        self.__fill_back_row()
        self.__fill_pawns_row()

    def move(self, color, start_pos, end_pos):
        a, b = start_pos
        x, y = end_pos
       
        if self.empty(start_pos):
            raise Exception("No piece at start_pos to be moved")
        elif self.rows[a, b].color != color:
            raise Exception("You must move your own piece")
        elif end_pos not in self.rows[a, b].moves():
            raise Exception("Invalid move")
        elif end_pos not in self.rows[a, b].valid_moves():
            raise Exception("Moving into check")

        self._execute_move(color, start_pos, end_pos)

    def valid(self, pos):
        x, y = pos[0], pos[1]
        return (0 <= x < 8 and 0 <= y < 8)

    def empty(self, pos):
        return (self.rows[pos[0], pos[1]] == self.nothing)

    def checkmate(self, color):
        if not self.in_check(color): return False

        pieces = self.find_pieces()
        for piece in pieces:
            if len(piece.valid_moves()) > 0:
                return False

        return True

    def in_check(self, color):
        if color == "white":
            opposite_color = "black"
        elif color == "black":
            opposite_color = "white"
        king_pos = self.find_king(color)
        pieces = self.find_pieces(opposite_color)
        for piece in pieces:
            moves = piece.moves()
            if king_pos in moves:
                return True
        return False
    
    def find_pieces(self, color):
        pieces = []
        for i in range(8):
            for j in range(8):
                if self.rows[i, j] != self.nothing and self.rows[i, j].color == color:
                    pieces.append(self.rows[i, j])
        return pieces

    def find_king(self, color):
        for i in range(8):
            for j in range(8):
                if type(self.rows[i, j]) == type(King("go", "a", "way")) and self.rows[i, j].color == color:
                    return [i, j]
        raise Exception("King not found")

    def _execute_move(self, color, start_pos, end_pos):
        a, b = start_pos
        x, y = end_pos

        self.rows[x, y] = self.rows[a, b]
        self.rows[x, y].pos = [x, y]
        self.rows[a, b] = self.nothing

    def __fill_back_row(self):
        back_row = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]

        for i in range(8):
            for j in range(8):
                if i == 0:
                    color = "black"
                elif i == 7:
                    color = "white"
                else:
                    break
                
                piece = back_row[j] 
                self.rows[i, j] = piece(color, self, [i, j])

    def __fill_pawns_row(self):
        for i in range(8):
            for j in range(8):
                if i == 1:
                    color = "black"
                elif i == 6:
                    color = "white"
                else:
                    break
                
                self.rows[i, j] = Pawn(color, self, [i, j])
