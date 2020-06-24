import matlab.engine
from tkinter import *
from tkinter import messagebox
import tkinter as tk 
import sys
import os
from predictioncode import predict
root= Tk()
root.title('Load File: Enter txt File Name')
root.geometry('400x25') 
tkWindow = Tk()
tkWindow.grid()
tkWindow.geometry('800x800')  
tkWindow.title('ECG Signal analysis')
def submit():
    name=name_entry.get()
    f=open('filename.txt','w')
    f.write(name)
    f.close()
    messagebox.showinfo("Submitted.", "Now Move to EC4G Signal analysis")

def o1():
    eng.so1()
def o2():
    eng.so2()
def o3():
    eng.so3()
def oo1():
    ret=eng.to1()
    messagebox.showinfo("Beats Per Minute: ", ret)
def oo2():
    ret=eng.to2()
    messagebox.showinfo("ST Segment: ", ret)
def oo3():
    ret=eng.to3()
    messagebox.showinfo("QT Interval: ", ret)
def oo4():
    ret=eng.to4()
    messagebox.showinfo("QRS Complex: ", ret)
def o4():
    eng.so4()
def o5():
    eng.so5()
def o6():
    eng.so6()
def o7():
    ret=predict()
    messagebox.showinfo("Disease: ",ret)
eng = matlab.engine.start_matlab()
#eng.PQRSTdetection(nargout=0)
button1 = Button(tkWindow,text = 'R peaks',command = o1)
button2 = Button(tkWindow,text = 'Q peaks',command = o2)  
button3 = Button(tkWindow,text = 'S peaks',command = o3)  
button4 = Button(tkWindow,text = '         BPM         ',command = oo1)  
button5 = Button(tkWindow,text = '   ST Segment   ',command = oo2)  
button6 = Button(tkWindow,text = '    QT Interval    ',command = oo3)  
button7 = Button(tkWindow,text = '  QRS Complex  ',command = oo4)  
button8 = Button(tkWindow,text = '      Combined Plot      ',command = o4)
button9 = Button(tkWindow,text = '       Original Signal       ',command = o5)
button10 = Button(tkWindow,text= ' Heart Rate Variablity ',command = o6)
button11 = Button(tkWindow,text= ' Prediction ',command = o7)
label1=Label(tkWindow, text=" Plots ",font=9)
label2=Label(tkWindow, text=" Measurements ",font=9)
label3=Label(tkWindow, text=" Peaks ",font=9)


name_var=tk.StringVar()
name_entry = tk.Entry(root, textvariable = name_var)
sub_btn=tk.Button(root,text = 'Submit',command = submit)


name_entry.grid(row=0,column=1)
sub_btn.grid(row=0,column=2)

label1.grid(row=1,column=1)
label2.grid(row=1,column=2)
label3.grid(row=1,column=3)

button4.grid(row=2,column=2)
button5.grid(row=3,column=2)
button6.grid(row=4,column=2)
button7.grid(row=5,column=2)

button9.grid(row=2,column=1)
button8.grid(row=3,column=1)
button10.grid(row=4,column=1)

button1.grid(row=2,column=3)
button2.grid(row=3,column=3)
button3.grid(row=4,column=3)

button11.grid(row=3,column=5)
tkWindow.mainloop()
