init:
	li	x15, 0x0000_F000	#loading 1000s position
	mv	x20, x0			#temp storage
	andi	x16, x11, x15		#preps x15 for 1000s read

loop1000s:
	beq	x16, x0, 100prep	#andi x16 next, loop ends
	addi	x20,x20, 1000		#increment total
admin1000s:
	addi	x16,x16, -0x1000	#decrease x16 value
	j	loop1000s		#return to 1000s read

100prep:
	andi	x16, x11, 0x0000_0F00	#100s place prep
	
loop100s:
	beq	x16,x0, 10prep		#for next andi x16. loop end
	addi	x20,x20, 100		#increment total
admin100s:
	andi	x16,x16,-0x100		#decrement loop count, decrease x16
	j	loop100s		#return to 100s loop

10prep:
	andi	x16, x11, 0x0000_00F0	#10s place prep
	
loop10s:
	beq	x16,x0, 1prep		#for next andi x16. loop end
	addi	x20,x20, 10		#increment total
admin10s:
	andi	x16,x16,-0x10		#decrement loop count, decrease x16
	j	loop10s			#return to 10s loop
	
1prep:
	andi	x16, x11, 0x0000_000F	#1s place prep
	
loop1s:
	beq	x16,x0, Done		#loop end condition.
	addi	x20,x20, 1		#increment total each iteration
admin1s:
	andi	x16,x16,-0x1		#decrement loop count, decrease x16
	j	loop1s			#return to 1s loop
	
Done:
	mv	x11, x20		#places the final value into x11
	
	mv	x16, x0			#clear x16 although it should be zero
	mv	x15, x0			#clear x15 from mask
	mv	x20, x0			#clear accumulated value from x20
	