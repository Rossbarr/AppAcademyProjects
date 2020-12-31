import tkinter as tk
import board
import display

class Game:
    def __init__(self):
        """
        Set up the players, game, and display.
        """
        self.players = ["white", "black"]
        self.__set_up_game()
        self.__set_up_display()

    def move(self, start_pos, end_pos, *promotion):
        """
        Try to move the piece
        Otherwise, print to console why we couldn't
        If we could move the piece, switch players and check for checkmate.
        """
        try:
            self.board.move(self.current_player, start_pos, end_pos, *promotion)
            if promotion is not ():
                self.display._destroy_buttons()
        except Exception as err:
            print("Exception occured: {}".format(err))
            return
        
        self.switch_player()
        self.check_for_checkmate()

    def switch_player(self):
        """
        switch the current player
        """
        if self.current_player == self.players[0]:
            self.current_player = self.players[1]
        else:
            self.current_player = self.players[0]
        
    def check_for_checkmate(self):
        """
        ...
        Check for checkmate
        ...
        Don't know what more to say
        """
        if self.board.checkmate(self.current_player):
            self.switch_player()
            print("{} wins!".format(self.current_player))

    def reset(self):
        """
        Reset the game
        Making a new board.
        """
        self.__set_up_game()
        self.display.board = self.board

    def __set_up_game(self):
        """
        Set up the game,
        creating a board
        """
        self.current_player = self.players[0]
        self.board = board.Board()

    def __set_up_display(self):
        """
        Set up the display.
        initializing a Display and giving it the board.
        """
        root = tk.Tk()
        self.display = display.Display(root, self, self.board)
        self.display.pack(side="top", fill="both", expand="true", padx=4, pady=4)
        root.mainloop()

if __name__ == "__main__":
    """
    If you ran this file,
    create and start a game.
    """
    game = Game()