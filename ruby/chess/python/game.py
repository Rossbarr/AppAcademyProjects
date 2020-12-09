import tkinter as tk
import board
import display

class Game:
    def __init__(self):
        self.players = ["white", "black"]
        self.__set_up_game()
        self.__set_up_display()

    def move(self, start_pos, end_pos):
        try:
            self.board.move(self.current_player, start_pos, end_pos)
        except Exception as err:
            print("Exception occured: {}".format(err))
            return
        
        self.switch_player()
        self.check_for_checkmate()

    def switch_player(self):
        if self.current_player == self.players[0]:
            self.current_player = self.players[1]
        else:
            self.current_player = self.players[0]
        
    def check_for_checkmate(self):
        if self.board.checkmate(self.current_player):
            self.switch_player()
            print("{} wins!".format(self.current_player))

    def reset(self):
        self.__set_up_game()
        self.display.board = self.board

    def __set_up_game(self):
        self.current_player = self.players[0]
        self.board = board.Board()

    def __set_up_display(self):
        root = tk.Tk()
        self.display = display.Display(root, self, self.board)
        self.display.pack(side="top", fill="both", expand="true", padx=4, pady=4)
        root.mainloop()

if __name__ == "__main__":
    game = Game()