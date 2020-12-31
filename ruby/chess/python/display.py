"""
This file contains the Display class.
This class handles the logic for rendering the board onto the screen 
and accepting user input.
"""

# We use tkinter as our GUI toolkit
import tkinter as tk
# We using PIL's ImageTK to load the images of the pieces.
from PIL import ImageTk

class Display(tk.Frame):
    """
    To be honest, I'm still not sure how tkinter works,
    but to get some functionally to our display we'll inherit from tk.Frame.
    """
    def __init__(self, main, game, board):
        """
        Arguments:
            Tk objects like button, frame, etc. require a reference to the "thing" they're in.
            This is usually called "master", but I called it main for the same reasons github does.

            The display needs to know the game object it's apart of so it can reference methods when necessarily.

            Additionally, display needs to know the board so that it can render it as it changes.

        Attributes:
            selected_piece is the piece object which was last clicked.
            Once you select a piece, you decide where to move it.

            highlighted is a list of valid moves that the selected piece can make.
            If you click a non-highlighted square, the selected_piece is dropped.

            icons assists in printing the images of the pieces to the screen.
            It's a dictionary of each piece to its appropriate image file.
            A white pawn, for example, will have it's own image. So will a black pawn.
            draw_pieces() fills this dictionary the first time it's called.
            To understand icons better, go to the draw_pieces() comments.
        """
        self.main = main
        main.title("Chessboard") # This just changes the window title.
        self.game = game
        self.board = board
        self.selected_piece = self.board.nothing
        self.highlighted = []
        self.icons = {}

        self.__create_board()
        self.__create_statusbar()
        self.draw_pieces()

    def click(self, event):
        """
        When a click occurs, we use the event to get the position
        of the click.

        We then use that position to determine what square and piece we clicked, if any.
        The console prints out our clicked position (was useful for debugging, can be deleted).

        The first time we click, if we click our piece, that piece is seleted.
        The squares that piece can move to are then highlighted.
        
        If we then click again, we attempt to move that piece to that position.
        Regardless of whether or not the piece can move to that position,
        we deselect the piece and unhighlight the squares.

        This creates an intuitive user input for selecting, deselecting, and moving pieces.
        """
        colsize = rowsize = 64

        # The canvas is 512 by 512.
        # But our board is 8 by 8
        # This converts our clicked position to what it is on the board.
        # (int floors the result of the division (quotient, I know))
        current_row = int(event.x / colsize)
        current_col = int(event.y / rowsize)

        print("You clicked {}, {}".format(current_col, current_row))
        
        clicked_position = [current_col, current_row]
        piece = self.selected_piece
        piece_position = self.selected_piece.pos
        
        # If we already have a piece selected.
        if piece is not self.board.nothing:
            # move the piece
            self.move(piece_position, clicked_position)
            # deselect
            self.selected_piece = self.board.nothing
            # highlight nothing
            self.highlighted = []
            # refresh the board
            self.refresh()
            # draw the pieces (as they may have moved)
            self.draw_pieces()
        # If we have no selected piece.
        else:
            # select the piece and highlight the appropriate squares
            self.highlight(clicked_position)
            # refresh the board
            self.refresh()
            # no need to redraw pieces as they can't have moved.

    def refresh(self, event=None):
        """
        This method refreshed the squares, not the pieces.
        As in, the color of the squares beneath the pieces is updated accordingly.

        tkinter requires refresh to have an optional event argument,
        even though we don't use it.
        """

        # Delete all the squares.
        self.canvas.delete("square")

        # Set the color variables
        color = "grey"
        for x in range(8):
            # Alternate colors.
            # First square is white
            # So color should first be grey
            # you can change these things around if you want.
            color = "white" if color == "grey" else "grey"
            for y in range(8):
                # Squares are 64 by 64, set up the bounds for this square.
                column_start = (x * 64)
                row_start = (y * 64)
                column_end = column_start + 64
                row_end = row_start + 64

                # If we've selected this position, color the square orange
                if self.selected_piece is not self.board.nothing and [x, y] == self.selected_piece.pos:
                    self.canvas.create_rectangle(row_start, column_start, row_end, column_end, 
                                                outline="black", fill="orange", tags="square")
                
                # if this square should be highlighted, color the square green
                elif [x, y] in self.highlighted:
                    self.canvas.create_rectangle(row_start, column_start, row_end, column_end, 
                                                outline="black", fill="spring green", tags="square")
                
                # Otherwise, color it according to the color variable (white or black)
                else:
                    self.canvas.create_rectangle(row_start, column_start, row_end, column_end, 
                                                outline="black", fill=color, tags="square")

                # change color
                color = "white" if color == "grey" else "grey"

        # change the text on the bottom to indicate current player.
        text = "{}'s turn".format(self.game.current_player)
        self.label_status['text'] = text

        # Render the pieces above the squares.
        self.canvas.tag_raise("piece")
        self.canvas.tag_lower("square")

    def move(self, start_position, end_position):
        """
        Move a position from one place to another.
        """
        a, b = start_position
        x = end_position[0]

        # Promoting a pawn gets special treatement
        # as we need to select what to promote into (Queen, Rook, Bishop, or Knight)
        if ((x == 0 or x == 7) and self.board.rows[a, b].symbol == "p"):
            self.__promote_pawn(start_position, end_position)
        # Otherwise, tell the game what move we wanna make.
        else:
            self.game.move(start_position, end_position)

    def highlight(self, position):
        """
        Select the piece and
        highlight the squares we want to move to
        """
        piece = self.board.rows[position[0], position[1]]
        if piece is not self.board.nothing and piece.color == self.game.current_player:
            # select the piece
            self.selected_piece = piece
            # highlight the squares the piece can move to
            self.highlighted = piece.valid_moves()

    def draw_pieces(self):
        """
        Like refresh, but for pieces.

        The first time this is called, an icons dictionary stores all the images
        for each piece in memory.
        This allows us to quickly call the iamges for the piece we need,
        instead of searching for the file each time.
        """

        # Delete all the pieces.
        self.canvas.delete("piece")
        for x in range(8):
            for y in range(8):
                piece = self.board.rows[x, y]
                #If there's a piece here...
                if piece is not self.board.nothing:
                    filename = "img/%s%s.png" % (piece.color, piece.symbol.lower())
                    piecename = "%s%s%s" % (piece.symbol, x, y)

                    if filename not in self.icons:
                        self.icons[filename] = ImageTk.PhotoImage(file=filename, width=32, height=32)
                    
                    # Place the piece on the square
                    self.addpiece(piecename, self.icons[filename], x, y)
        
    def addpiece(self, name, image, x, y):
        """
        Place the piece at the location
        """
        # Put it in the center of the square.
        column = (x * 64) + 32
        row = (y * 64) + 32
        self.canvas.create_image(row, column, image=image, tags=(name, "piece"), anchor="c")

    def reset(self):
        """
        Reset the board
        Used by the "New" button.
        """
        self.game.reset()
        self.selected_piece = self.board.nothing
        self.highlighted = []
        self.pieces = {}
        self.refresh()
        self.draw_pieces()

    def __create_board(self):
        """
        Create the board.
        """
        tk.Frame.__init__(self, self.main)

        self.canvas = tk.Canvas(self, width=8*64, height=8*64, background="grey")
        self.canvas.pack(side="top", fill="both", anchor="c", expand=True)

        self.canvas.bind("<Configure>", self.refresh)
        self.canvas.bind("<Button-1>", self.click)

    def __create_statusbar(self):
        """
        Create the lower statusbar
        """
        self.statusbar = tk.Frame(self, height=64)
        
        self.button_quit = tk.Button(self.statusbar, text="New", fg="black", command=self.reset)
        self.button_quit.pack(side=tk.LEFT, in_=self.statusbar)

        self.button_quit = tk.Button(self.statusbar, text="Quit", fg="black", command=self.main.destroy)
        self.button_quit.pack(side=tk.LEFT, in_=self.statusbar)

        self.label_status = tk.Label(self.statusbar, text="{}'s turn".format(self.game.current_player), fg="black")
        self.label_status.pack(side=tk.LEFT, in_=self.statusbar)

        self.statusbar.pack(expand=False, fill="x", side="bottom")

    def __promote_pawn(self, start_position, end_position):
        """
        Create buttons for promoting pawns
        """
        self.button_queen = tk.Button(self.statusbar, text="Queen", fg="black", 
            command= lambda: self.game.move(start_position, end_position, "Q"))
        self.button_queen.pack(side=tk.RIGHT, in_=self.statusbar)

        self.button_rook = tk.Button(self.statusbar, text="Rook", fg="black", 
            command= lambda: self.game.move(start_position, end_position, "R"))
        self.button_rook.pack(side=tk.RIGHT, in_=self.statusbar)

        self.button_bishop = tk.Button(self.statusbar, text="Biship", fg="black", 
            command= lambda: self.game.move(start_position, end_position, "B"))
        self.button_bishop.pack(side=tk.RIGHT, in_=self.statusbar)

        self.button_knight = tk.Button(self.statusbar, text="Knight", fg="black", 
            command= lambda: self.game.move(start_position, end_position, "N"))
        self.button_knight.pack(side=tk.RIGHT, in_=self.statusbar)

    def _destroy_buttons(self):
        """
        Destroy the buttons for promoting a pawn
        (called by Game.)
        """
        self.button_queen.destroy()
        self.button_rook.destroy()
        self.button_bishop.destroy()
        self.button_knight.destroy()
    
        self.refresh()
        self.draw_pieces()
