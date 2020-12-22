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
        colsize = rowsize = 64

        current_row = int(event.x / colsize)
        current_col = int(event.y / rowsize)

        print("You clicked {}, {}".format(current_col, current_row))
        
        clicked_position = [current_col, current_row]
        piece = self.selected_piece
        piece_position = self.selected_piece.pos
        
        if piece is not self.board.nothing:
            self.move(piece_position, clicked_position)
            self.selected_piece = self.board.nothing
            self.highlighted = []
            self.refresh()
            self.draw_pieces()
        else:
            self.highlight(clicked_position)
            self.refresh()

    def refresh(self, event = {}):
        if event:
            xsize = int((event.width-1) / 8)
            ysize = int((event.width-1) / 8)
            self.square_size = min(xsize, ysize)

        self.canvas.delete("square")
        color = "grey"
        for x in range(8):
            color = "white" if color == "grey" else "grey"
            for y in range(8):
                column_start = (x * 64)
                row_start = (y * 64)
                column_end = column_start + 64
                row_end = row_start + 64
                if self.selected_piece is not self.board.nothing and [x, y] == self.selected_piece.pos:
                    self.canvas.create_rectangle(row_start, column_start, row_end, column_end, 
                                                outline="black", fill="orange", tags="square")
                elif [x, y] in self.highlighted:
                    self.canvas.create_rectangle(row_start, column_start, row_end, column_end, 
                                                outline="black", fill="spring green", tags="square")
                else:
                    self.canvas.create_rectangle(row_start, column_start, row_end, column_end, 
                                                outline="black", fill=color, tags="square")
                color = "white" if color == "grey" else "grey"

        text = "{}'s turn".format(self.game.current_player)
        self.label_status['text'] = text

        self.canvas.tag_raise("piece")
        self.canvas.tag_lower("square")

    def move(self, start_position, end_position):
        self.game.move(start_position, end_position)

    def highlight(self, position):
        piece = self.board.rows[position[0], position[1]]
        if piece is not self.board.nothing and piece.color == self.game.current_player:
            self.selected_piece = piece
            self.highlighted = piece.valid_moves()

    def draw_pieces(self):
        self.canvas.delete("piece")
        for x in range(8):
            for y in range(8):
                piece = self.board.rows[x, y]
                if piece is not self.board.nothing:
                    filename = "img/%s%s.png" % (piece.color, piece.symbol.lower())
                    piecename = "%s%s%s" % (piece.symbol, x, y)

                    if filename not in self.icons:
                        self.icons[filename] = ImageTk.PhotoImage(file=filename, width=32, height=32)

                    self.addpiece(piecename, self.icons[filename], x, y)
        
    def addpiece(self, name, image, x, y):
        column = (x * 64) + 32
        row = (y * 64) + 32
        self.canvas.create_image(row, column, image=image, tags=(name, "piece"), anchor="c")

    def reset(self):
        self.game.reset()
        self.selected_piece = self.board.nothing
        self.highlighted = []
        self.pieces = {}
        self.refresh()
        self.draw_pieces()

    def __create_board(self):
        tk.Frame.__init__(self, self.main)

        self.canvas = tk.Canvas(self, width=8*64, height=8*64, background="grey")
        self.canvas.pack(side="top", fill="both", anchor="c", expand=True)

        self.canvas.bind("<Configure>", self.refresh)
        self.canvas.bind("<Button-1>", self.click)

    def __create_statusbar(self):
        self.statusbar = tk.Frame(self, height=64)
        
        self.button_quit = tk.Button(self.statusbar, text="New", fg="black", command=self.reset)
        self.button_quit.pack(side=tk.LEFT, in_=self.statusbar)

        self.button_quit = tk.Button(self.statusbar, text="Quit", fg="black", command=self.main.destroy)
        self.button_quit.pack(side=tk.LEFT, in_=self.statusbar)

        self.label_status = tk.Label(self.statusbar, text="{}'s turn".format(self.game.current_player), fg="black")
        self.label_status.pack(side=tk.LEFT, in_=self.statusbar)

        self.statusbar.pack(expand=False, fill="x", side="bottom")