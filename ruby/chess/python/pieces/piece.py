"""
This file contains the Piece and NullPiece classes.
Piece is a parent of all "piece-type" objects (e.g. pawn, queen, knight, etc.) and the NullPiece.
"""

class Piece():
    def __init__(self, color, board, pos):
        """
        When a piece is initialized, it has 4 attributes.
        Each of these attributes helps decide when and how a piece can move.
            1. color
                str: "white" or "black"
            2. board
                object: Board class
            3. pos (position)
                array: length 2, containing integers
            4. moved
                bool
                This is initialized as false and is set to true when the piece moves once.
                The king, rook, and pawn lose out on some movement options after moving once.
                This is the simplest way to check to see if they've ever moved.

        """
        self.color = color
        self.board = board
        self.pos = pos
        self.moved = False

    def moves(self):
        """
        This method is to be overwritten by all child class pieces.
        
        This method returns an array containing the movement options of that piece.
        Since pieces move differently depending on what they are,
        this method will be defined in each piece.
        """
        return []

    def valid_moves(self):
        """
        valid_moves() takes the list of possible moves (from moves()) and narrows it further.
        If a move doesn't place the user into check, the move is valid.
        The move is placed into a new array that is returned.
        """
        moves = self.moves()
        valid_moves = []
        for move in moves:
            if not self.__moves_into_check(move):
                valid_moves.append(move)
        return valid_moves

    def __moves_into_check(self, end_pos):
        """
        This method creates a deepcopy of the board and executes a move.
        If the move results in a check upon oneself
        (the opponent can kill the king if this move is played), 
        the move is invalid and false is returned.
        """
        test_board = self.board.deepcopy()
        test_board._execute_move(self.color, self.pos, end_pos, "Q")
        result = test_board.in_check(self.color)
        return result

class NullPiece(Piece):
    """
    Although it might be a bit more efficient to use None 
    instead of NullPiece for empty squares, I opted to use NullPiece.
    There are two reasons:
        1. The Board classes uses a 2D numpy array to keep track of its board.
            The data type of things inside a numpy array must be the same.
            With NullPiece, they are all be objects.
            By using None, I may run into problems as None is NoneTyped.
            I will admit, this wasn't tested, so I may be incorrect.

        2. It will inherit methods and attributes of Piece.
            If an empty square is called as if it's a piece,
            instead of throwing an immediate error and stopping the program,
            the NullPiece will simply return info the check isn't looking for.
            This is opposed to checking if the piece is None each time.

    If this doesn't really make sense to you,
    and you think there are more advantages to using None instead of NullPiece,
    let me know, I would really like to discuss it or program it.
    I didn't really give None a chance during my first go.
    """
    def __init__(self):
        self.symbol = ""
        self.color = ""
        self.pos = [8, 8]
        self.moved = True