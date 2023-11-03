part1:

init:   li	x1, 0xC00000BB		#load t3 with the word from address
	lw	x5, 0(x1)
	li	x2, 10			#immediate load 10 into x2
	li	x3, 0			#immediate load 0 into x3
	li	x4, 0xC00000FF		#Loads outport address to x4

loop:	beq	x0, x2, Done		#branch if a0 is equal to 0
	add	x3, x3, x5		#adds the current value of t0 to t3 (multiplication with loop)
	addi	x2, x2, -1			#reduces a0 by 1 to lower cycle count left
	j	loop			#jump to loop to continue cycle



Done:	sw	x3, 0(x4)			#loads 10 multiplied value into outport
	ret				#returns through the output port




