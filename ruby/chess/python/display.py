import tkinter as tk
import board
from PIL import ImageTk

class Display(tk.Frame):
    def __init__(self, main, board):
        self.main = main
        main.title("Chessboard")
        self.board = board
        self.selected_piece = (self.board.nothing, None)
        self.highlighted = (self.board.nothing, None)
        self.icons = {}
        self.pieces = {}

        self.__create_board()
        self.__create_statusbar()
        self.draw_pieces()

    def click(self, event):
        colsize = rowsize = 64

        current_row = int(event.x / colsize)
        current_col = int(event.y / rowsize)

        print("You clicked {}, {}".format(current_col, current_row))
        
        position = [current_col, current_row]
        piece = self.board.rows[current_col, current_row]
        
        if self.selected_piece[0] is not self.board.nothing:
            try:
                self.move(self.selected_piece[0].color, self.selected_piece[1], position)
            except Exception:
                print("Exception occurred, try again.")
            self.selected_piece = (self.board.nothing, None)
            self.highlighted = (self.board.nothing, None)
            self.pieces = {}
            self.refresh()
            self.draw_pieces()
        else:
            self.highlight(position)
            self.refresh()

    def reset(self):
        pass

    def chessboard_save_to_file(self):
        pass

    def refresh(self, event = {}):
        if event:
            xsize = int((event.width-1) / 8)
            ysize = int((event.width-1) / 8)
            self.square_size = min(xsize, ysize)

        self.canvas.delete("square")
        color = "grey"
        for row in range(8):
            color = "white" if color == "grey" else "grey"
            for column in range(8):
                x1 = (column * 64)
                y1 = ((row) * 64)
                x2 = x1 + 64
                y2 = y1 + 64
                if self.selected_piece[0] is not self.board.nothing and [row, column] == self.selected_piece[1]:
                    self.canvas.create_rectangle(x1, y1, x2, y2, outline="black", fill="orange", tags="square")
                elif self.highlighted[0] is not self.board.nothing and [row, column] in self.highlighted[1]:
                    self.canvas.create_rectangle(x1, y1, x2, y2, outline="black", fill="spring green", tags="square")
                else:
                    self.canvas.create_rectangle(x1, y1, x2, y2, outline="black", fill=color, tags="square")
                color = "white" if color == "grey" else "grey"

        for name in self.pieces:
            self.placepiece(name, self.pieces[name][0], self.pieces[name][1])

        self.canvas.tag_raise("piece")
        self.canvas.tag_lower("square")

    def move(self, color, position1, position2):
        self.board.move(color, position1, position2)

    def highlight(self, position):
        piece = self.board.rows[position[0], position[1]]
        if piece is not self.board.nothing and piece.color == piece.color: #check current player color against piece color
            self.selected_piece = (piece, position)
            self.highlighted = (piece, piece.valid_moves())

    def addpiece(self, name, image, row, column):
        self.canvas.create_image(0, 0, image=image, tags=(name, "piece"), anchor="c")
        self.placepiece(name, row, column)

    def placepiece(self, name, row, column):
        self.pieces[name] = (row, column)
        x = (column * 64) + 32
        y = ((row) * 64) + 32
        self.canvas.coords(name, x, y)

    def draw_pieces(self):
        self.canvas.delete("piece")
        for x in range(8):
            for y in range(8):
                piece = self.board.rows[x][y]
                if piece is not self.board.nothing:
                    filename = "img/%s%s.png" % (piece.color, piece.symbol.lower())
                    piecename = "%s%s%s" % (piece.symbol, x, y)

                    if filename not in self.icons:
                        self.icons[filename] = ImageTk.PhotoImage(file=filename, width=32, height=32)

                    self.addpiece(piecename, self.icons[filename], x, y)

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

        self.button_save = tk.Button(self.statusbar, text="Save", fg="black", command=self.chessboard_save_to_file)
        self.button_save.pack(side=tk.LEFT, in_=self.statusbar)

        self.label_status = tk.Label(self.statusbar, text="   White's Turn   ", fg="black")
        self.label_status.pack(side=tk.LEFT, in_=self.statusbar)

        self.button_quit = tk.Button(self.statusbar, text="Quit", fg="black", command=self.main.destroy)
        self.button_quit.pack(side=tk.LEFT, in_=self.statusbar)

        self.statusbar.pack(expand=False, fill="x", side="bottom")

if __name__ == "__main__":
    root = tk.Tk()
    gui = Display(root, board.Board())
    gui.pack(side="top", fill="both", expand="true", padx=4, pady=4)
    root.mainloop()
