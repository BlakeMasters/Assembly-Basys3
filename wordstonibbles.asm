reformatting_memory:

init:
	mv	x13,a0		#copy start address
	
	add	x6,a1,a1	#2 of 4 for a0 + 4a1
	add	x6,x6,a1	#3 of 4
	add	x6,x6,a1	#4 of 4. keep x6 needed for looping back
	add	x7,x6,a0	#starting point a0 + 4a1 for new memory
	mv	x8, x7		#Copy of starting address for new
	
loop_grab:
	beq	a1,x0,loop_store	#when looping is done, next loop
	lw	x9, 0(a0)	#take word from a0
	
	addi	x10,x0,8	#subroutine loop count. 8 nibbles per word
	mv	x11, x9		#copy x9 value. have to change in sub
	j	perword		#modular design, perword could be witihin loop 1
loopgrab_admin:
	addi	a1,a1,-1	#reduces words needed by 1. loop down
	addi	a0,a0,4		#next word position
	j	loop_grab	#run it back
	
perword:
	beq	x10,x0,loopgrab_admin	#if done with word, go back to l1 
	andi	x11,x11,0xF	#grabs bottom nibble
	sw	x7, 0(x11)	#stores bottom nibble as word to start location
admin_perword:
	addi	x10,x10,-1	#lower subroutine count by 1
	srli	x11,x11,4	#shift to next lowest nibble
	addi	x7,x7,4		#next memory position. 4 bytes per word

loop_store:
	beq	x6,x0,done	#when done looping, come home
	
	lw	x12, 0(x8)	#take word from copied start
	sw	x13, 0(x12)	#stores nibbles->word to a0 copy
loopstore_admin:
	addi	x6,x6,-1	#reduce loop count. nibbles in a1 words -> new word count
	addi	x8,x8,4		#next word from x8
	addi	x13,x13,4	#next word memory from a0 start

done:
	ret			#God has forsaken me
	
	
	
	

	
