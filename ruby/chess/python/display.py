import tkinter as tk

window = tk.Tk()

for i in range(8):
    for j in range(8):
        button = tk.Button(
                master = window,
                relief = tk.RAISED,
                borderwidth = 1
                )
        button.grid(row = i, column = j, padx = 5, pady = 5)
        label = tk.Label(master = button, text = f"Row {i}\nColumn {j}")
        label.pack()

window.mainloop()
