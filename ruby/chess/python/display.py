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
        Tk objects like button, frame, etc. require a reference to the "thing" they're in.
        This is usually called "master", but I called it main for the same reasons github does.

        The display needs to know the game object it's apart of so it can reference methods when necessarily.

        Additionally, display needs to know the board so that it can render it as it changes.

        There are two attributes called selected_piece and highlighted which follow.
            selected_piece is a tuple (think list but immutable) containing
                1. the piece object which was last clicked.
                2. it's position (a list)
            At this point, you might be thinking that seems kinda ricidulous.
            If I have one of those values, I can get the other:
                Since I have the piece, and the piece contains an attribute for its position, I can get that
                Since I have the position, I can ask the board if and what piece is there.
            The reason it's currently left the way it is is because I'm lazy.
            I was trying to decide if a piece should have a reference to its own position.
            And while deciding that, I've left this as it was originally formed.
            I'll "hopefully" optimize it eventually.

            highlighted is a list of valid moves that the selected piece can make.
            This is, I think, as effecient as it gets.
            It's only generated if there's a selected piece,
            otherwise it's empty.
            If you have any ideas or suggestions, let me know.

        icons assists in printing the images of the pieces to the screen.
            It's a dictionary of each piece to its appropriate image file.
            A white pawn, for example, will have it's own image. So will a black pawn.
            draw_pieces() fills this dictionary in full the first time it's called.
            To understand icons better, go to the draw_pieces() comments.
        """
        self.main = main
        main.title("Chessboard") # This just changes the window title.
        self.game = game
        self.board = board
        self.selected_piece = (self.board.nothing, None)
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
        piece = self.selected_piece[0]
        piece_position = self.selected_piece[1]
        
        if piece is not self.board.nothing:
            self.move(piece_position, clicked_position)
            self.selected_piece = (self.board.nothing, None)
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
                if self.selected_piece[0] is not self.board.nothing and [x, y] == self.selected_piece[1]:
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
            self.selected_piece = (piece, position)
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
        self.selected_piece = (self.board.nothing, None)
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