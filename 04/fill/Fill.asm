// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input. 
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel. When no key is pressed, the
// program clears the screen, i.e. writes "white" in every pixel.

// Put your code here.

(START)
@SCREEN
D=A
@0
M=D

(CHECK)

@KBD
D=M
@BLK
D;JGT
@WHT
D;JEQ

@CHECK
0;JMP

(BLK)
@1
M=-1
@SWITCH

(WHT)
@1
M=0
@SWITCH
0;JMP

(SWITCH)
@1
D=M

@0
A=M
M=D

@0
D=M+1
@KBD
D=A-D

@0
M=M+1
A=M

@SWITCH
D;JGT

@START
0;JMP