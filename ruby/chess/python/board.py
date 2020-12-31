"""
This file contains the Board class.
The board itself handles coordinating with pieces to move them around.
"""

"""
To explain the imports below:

A 2D numpy array is used to store the board and all the pieces on it (see below)
sys is imported to append the pieces folder for the search path.
deepcopy, from copy, is imported as a deepcopy is used to check if moves are valid,
more on that below.
"""

import numpy as np
import sys
sys.path.append('pieces/')
from copy import deepcopy

"""
Importing all the pieces, as they need to be initialized on the board.
"""
from pieces.king import King
from pieces.queen import Queen
from pieces.rook import Rook
from pieces.bishop import Bishop
from pieces.knight import Knight
from pieces.pawn import Pawn
from pieces.piece import NullPiece

class Board:
    """
    Set deepcopy to be a Board method.
    """
    deepcopy = deepcopy

    def __init__(self):
        """
        When a board is initialized, going in order of the statements below:
        
        1. Initialize a NullPiece to be placed in the empty squares.

        2. Set last_move to nothing

        3. Create an empty 2D numpy array

        4. Call __fill_back_row()
            Fills the back rows on both sides, filling them with pieces.
            (I'd recommend looking at this method next, or just trust it works)

        5. Call __fill_pawns_row()
            Fills the pawn rows on both sides, filling them with pawns.
            (I'd recommend looking at this method after the above one.)
        """
        self.nothing = NullPiece()
        self.last_move = (self.nothing, [0, 0], [0, 0])
        self.rows = np.full(shape = (8,8), fill_value = self.nothing)
        self.__fill_back_row()
        self.__fill_pawns_row()

    def move(self, color, start_pos, end_pos, *promotion):
        """
        move, as the name implies, moves a piece from one square to another.
        The Game object will call this method, giving:
            1. the color of the current player
            2. the starting position the player clicked
            3. the ending position the player clicked.
            4. (optional) the piece button the player clicked (ONLY WHEN PROMOTING)

        This method then checks that everything is in order:
            there's a piece,
            the piece is the player's,
            the piece can move like that,
            the move doesn't move into check.
        
        If all this works, then it executes the move.
        """
        a, b = start_pos
       
        if self.empty(start_pos):
            raise Exception("No piece at start_pos to be moved")
        elif self.rows[a, b].color != color:
            raise Exception("You must move your own piece")
        elif end_pos not in self.rows[a, b].moves():
            raise Exception("Invalid move")
        elif end_pos not in self.rows[a, b].valid_moves():
            raise Exception("Moving into check")

        self._execute_move(color, start_pos, end_pos, *promotion)

    def valid(self, pos):
        """
        Checks if the position given is on the board.
        """
        x, y = pos[0], pos[1]
        return (0 <= x < 8 and 0 <= y < 8)

    def empty(self, pos):
        """
        Checks if the position given is empty.
        Remember that self.nothing is the NullPiece we initialized
        when creating the board.
        It is the placeholder for an empty square.
        """
        return (self.rows[pos[0], pos[1]] == self.nothing)

    def checkmate(self, color):
        """
        Checks for checkmate on the color given.
        """

        # Can't be in checkmate if we're not in check.
        if not self.in_check(color): return False

        # Find all the pieces of that color
        pieces = self.find_pieces(color)
        for piece in pieces:
            # If one of them has a valid move, then we're not in checkmate.
            if len(piece.valid_moves()) > 0:
                return False
        
        # Otherwise we're in checkmate.
        return True

    def in_check(self, color):
        """
        Check if the color is in check.
        """

        # We need to know what the opposite color is,
        # because that's how we'll check if we're in checkmate.
        if color == "white":
            opposite_color = "black"
        elif color == "black":
            opposite_color = "white"

        # Find our king
        king_pos = self.find_king(color)
        # Find all their pieces.
        pieces = self.find_pieces(opposite_color)
        for piece in pieces:
            if piece.symbol is not "K":
                moves = piece.moves()
                # If one of their pieces can capture our king
                # Then we're in check
                if king_pos in moves:
                    return True

        # Otherwise we're not.
        return False
    
    def find_pieces(self, color):
        """
        Find all the pieces of a color.
        """
        pieces = []
        for i in range(8):
            for j in range(8):
                if self.rows[i, j] != self.nothing and self.rows[i, j].color == color:
                    pieces.append(self.rows[i, j])
        return pieces

    def find_king(self, color):
        """
        Find the king of a color.
        """
        for i in range(8):
            for j in range(8):
                if self.rows[i, j].symbol == "K" and self.rows[i, j].color == color:
                    return [i, j]
        raise Exception("King not found")

    def _execute_move(self, color, start_pos, end_pos, *promotion):
        """
        This method executes a move without doing any checks.
        As in, this is the method that actually does the moving.
        move() calls this method.

        Why separate?
        This is useful for checking if a move places one into check.
        
        When a piece is asked to move, it creates a deepcopy of the board.
        It then forces this board copy to make a move, and
        it checks if the resulting position creates a check for oneself.
        If it does, that move cannot be played and a false is returned.
        See piece.__moves_into_check() for more.
        """
        a, b = start_pos
        x, y = end_pos

        piece = self.rows[a, b]
        # If we're trying to castle...
        if piece.symbol == "K" and abs(b - y) == 2:
            self.__castle(color, start_pos, end_pos)
        # If we're trying to promote...
        elif (piece.symbol == "p" and 
                (x == 0 or x == 7)):
            self.__promote_pawn(color, start_pos, end_pos, *promotion)
        # If we want to play en passent...
        elif (piece.symbol == "p" and
                self.last_move[0].symbol == "p" and
                abs(self.last_move[2][0] - self.last_move[1][0]) == 2 and
                (a == 3 and color == "white" or
                a == 4 and color == "black") and
                abs(y - b) == 1):
            self.__en_passent(color, start_pos, end_pos)
        # Otherwise...
        else:
            # Set the end position to be the piece.
            self.rows[x, y] = piece
            # Correct the piece's position.
            piece.pos = [x, y]
            # The piece has moved.
            piece.moved = True
            # Set where the piece was to nothing.
            self.rows[a, b] = self.nothing
            # Correct the last_move.
            self.last_move = (piece, start_pos, end_pos)

    def __castle(self, color, start_pos, end_pos):
        """
        This method handles the logic for castling.
        
        If you're worried there's not enough checks, 
        there are more in the King class.
        """
        a, b = start_pos
        x, y = end_pos

        # grab the king
        king = self.rows[a, b]
        # left castle
        if y - b == -2:
            # grab the rook
            rook = self.rows[a, 0]
            # move the king
            self.rows[x, y] = king
            # move the rook
            self.rows[x, y + 1] = rook
            # correct king position
            king.pos = [x, y]
            # correct rook position
            rook.pos = [x, y + 1]
            # the king has moved
            king.moved = True
            # the rook has moved
            rook.moved = True
            # Empty the squares
            self.rows[a, b] = self.nothing
            self.rows[a, 0] = self.nothing
            # set the last move
            self.last_move = (king, start_pos, end_pos)
        # right castle
        else:
            # grab the rook
            rook = self.rows[a, 7]
            # move the king
            self.rows[x, y] = king
            # move the rook
            self.rows[x, y - 1] = rook
            # correct king position
            king.pos = [x, y]
            # correct rook position
            rook.pos = [x, y - 1]
            # the king has moved
            king.moved = True
            # the rook has moved
            rook.moved = True
            # Empty the squares
            self.rows[a, b] = self.nothing
            self.rows[a, 7] = self.nothing
            # set the last move
            self.last_move = (king, start_pos, end_pos)

    def __en_passent(self, color, start_pos, end_pos):
        """
        This method handles the logic for playing en passent

        I'm not going to comment this one much because of how much
        _execute_move and __castle are commented.
        You can probably figure this out.
        """
        a, b = start_pos
        x, y = end_pos

        piece = self.rows[a, b]

        self.rows[self.last_move[2][0], self.last_move[2][1]] = self.nothing
        self.rows[x, y] = piece
        piece.pos = [x, y]
        piece.moved = True
        self.rows[a, b] = self.nothing
        self.last_move = (piece, start_pos, end_pos)

    def __promote_pawn(self, color, start_pos, end_pos, promotion):
        """
        This method handles the logic for promoting

        I'm not going to comment this one much because of how much
        _execute_move and __castle are commented.
        You can probably figure this out.
        """
        a, b = start_pos
        x, y = end_pos

        piece = self.rows[a, b]

        # Check what we want to promote into.
        if promotion == "Q":
            promotion = Queen
        elif promotion == "R":
            promotion = Rook
        elif promotion == "B":
            promotion = Bishop
        else:
            promotion = Knight

        self.rows[x, y] = promotion(color, self, end_pos)
        piece.pos = [8, 8]
        piece.moved = True
        self.rows[a, b] = self.nothing
        self.last_move = (piece, start_pos, end_pos)        

    def __fill_back_row(self):
        """
        This method fills rows 0 and 7, the rows on opposite sides.
        """

        # this list shows the pieces in order.
        back_row = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]

        # We iterate through every square...
        for i in range(8):
            for j in range(8):
                # if the square is the first or last row, set the color appropriately
                # otherwise ignore that row.
                if i == 0:
                    color = "black"
                elif i == 7:
                    color = "white"
                else:
                    break # Minor optimization
                
                # Set the piece we initialize based on where we are.
                # Look at a chessboard if this is confusing:
                # Notice how the pieces are opposite one another.
                piece = back_row[j] 
                self.rows[i, j] = piece(color, self, [i, j])

    def __fill_pawns_row(self):
        """
        This method fills the rows holding all the pawns, rows 1 and 6.
        It works very similarly to __fill_back_row().
        If you can understand the above method, you can understand this one
        and vice versa.
        """
        for i in range(8):
            for j in range(8):
                if i == 1:
                    color = "black"
                elif i == 6:
                    color = "white"
                else:
                    break
                
                self.rows[i, j] = Pawn(color, self, [i, j])
