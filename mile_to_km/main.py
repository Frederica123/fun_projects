from tkinter import *

window = Tk()
window.title("Miles to Km Converter")
window.minsize(width=300, height=200)
window.config(padx=100, pady=50)

#Label

mile_label = Label(text="Miles", font=("Arial", 15))
mile_label.grid(column=2, row=0)
equal_label = Label(text="is equal", font=("Arial", 15))
equal_label.grid(column=0, row=1)
number_label = Label(text="0", font=("Arial", 15))
number_label.grid(column=1, row=1)
km_label = Label(text="Km", font=("Arial", 15))
km_label.grid(column=2, row=1)

#Button
def button_clicked():
    print("I Got Clicked")
    new_text = input.get()
    number_label.config(text=str("{:.2f}".format(float(new_text)/1.61)))
    # my_label["text"] = "Button Got Clicked"

button = Button(text="Calculate",command=button_clicked)
# button.pack()
button.grid(column=1, row=2)

#Entry
input = Entry(width=10)
input.insert(END, string="0")
# input.pack()
# input.place(x=100,y=200)
input.grid(column=1, row=0)


window.mainloop()