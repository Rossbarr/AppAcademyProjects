"""
This file contains the Piece and NullPiece classes.
Piece is a parent of all "piece-type" objects (e.g. pawn, queen, knight, etc.) and the NullPiece.
"""

class Piece():
    def __init__(self, color, board, pos):
        """
        When a piece is initialized, it has 4 attributes.
            1. color
                str: "white" or "black"
                A piece's color is static, never changing.
                It should know it's own color so it can decide how it should be able to move.
                (e.g. pawns, whether they're white or black, can only move in one direction.)
            2. board
                object: Board class
                When developing possible moves, the piece must ask the board about its state
                (where are other pieces, will I move into check, etc.)
            3. pos
                array: length 2, containing integers
                The piece knows about it's position so that it can develop its list of moves accordingly.
                The obvious alternative here is to have the board tell the piece where it is,
                There are advantages and disadvantages to both systems.
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
        
        This method (when overwritten by a child class) will return an array.
        This array contains the possible movement locations of that piece.
        Since pieces move different according to what they are,
        this method will be defined in each piece.
        """
        return []

    def valid_moves(self):
        """
        This method may seem confusing if you haven't looked at an individual piece to see what
        the moves() method does.

        Each piece class has a moves() method to generate a list of possible moves as an array.
        This method checks how the piece can move (e.g. if it slides diagonally or not),
        and looks at the places it can move to to see if there are obstacles or the edge of the board.
        
        valid_moves() takes that list of possible moves and narrows it down further.
        If the move doesn't place the user into check, the move is allowed or valid.
        The return value is an array of possible move locations.
        """
        possible_moves = self.moves()
        allowed_moves = []
        for move in possible_moves:
            if not self.__moves_into_check(move):
                allowed_moves.append(move)
        return allowed_moves

    def __moves_into_check(self, end_pos):
        """
        This method creates a deepcopy of the board and executes a move.
        If the move results in a check upon oneself (that is, the opponent can kill the king),
        false is returned.

        This method would benefit the most from having the piece not know it's own position.
        A deepcopy of the board must be generated.
        If a shallow copy is used instead, the pieces themselves may become confused as to where they are.
        That is, a piece's position may not line up with the board's knowledge of that piece's position.
        """
        test_board = self.board.deepcopy()
        test_board._execute_move(self.color, self.pos, end_pos, "Q")
        result = test_board.in_check(self.color)
        if result:
            print("{} moves into check".format(end_pos))
        return result

class NullPiece(Piece):
    """
    Although it might be easier and a bit more efficient to use None 
    instead of NullPiece to indicate an empty square, I opted to use NullPiece.
    There are a few reasons:
        1. The Board classes uses a 2D numpy array to keep track of its board.
            The data type of the things inside the array must be the same.
            In this case, they can all be objects.
            By using None, I may run into problems as None is NoneTyped.
            I will admit, this wasn't fully tested, but it's a micro-optimization anyway.

        2. It will inherit methods and attributes of Piece.
            The advantage here is that if an empty square is called incorrectly,
            I can better see why an error was thrown,
            and/or I can control the errors that get thrown so the caller can react accordingly.

    If this doesn't really make sense to you,
    and you think there are more advantages to using None instead of NullPiece,
    let me know, I would really like to discuss it or program it.
    As I said, I didn't really give None a chance during my first go.
    """
    def __init__(self):
        self.symbol = ""
        self.moved = True
        self.pos = [8, 8]