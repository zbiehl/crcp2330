// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Mult.asm

// Multiplies R0 and R1 and stores the result in R2.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)

// Put your code here.

	@R0
	D=M
	@multOne
	M=D  // multOne = R0

	@R1
	D=M
	@multTwo
	M=D // multTwo = R1

	@0
	D=A
	@R2
	M=D // R2 = 0

	(START)
	@multOne
	D=M
	@END
	D;JLE

	@multTwo
	D=M
	@R2
	M=D+M

	@multOne
	M=M-1

	@START
	0;JMP

	(END)
	@END
	0;JMP

	