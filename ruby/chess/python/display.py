import tkinter as tk

class Display(tk.Frame):
    def __init__(self, main):
        self.main = main
        main.title("Chessboard")
        self.create_board()

    def create_board(self):
        for i in range(8):
            for j in range(8):
                frame = tk.Frame(master = self.main, relief = tk.RAISED, borderwidth = 1)
                frame.grid(row = i, column = j, padx = 5, pady = 5)
                button = tk.Button(master = frame, text = f"Row {i}\nColumn {j}")
                button["command"] = self.change_buttons
                button.pack()

    def change_buttons(self):
        pass
        for i in range(8):
            for j in range(8):
                pass


    def print_hello(self):
        print("Hello")

    def print_goodbye(self):
        print("Goodbye")



root = tk.Tk()
chessboard = Display(root)
root.mainloop()
