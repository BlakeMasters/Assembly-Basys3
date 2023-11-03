my_prog:	
		li	x10, 0xC000FFFF		# input address
		li	x11, 0xD000000D		# first 2 output address
		li	x12, 0xF000000F		# second 2 output address
main:
		lw	x20,0 (x10)		# input data #load from 10
		lw	x21,0 (x10)		# input data #load from 10
		add	x20,x20,x21		# changed addi to add
		sw	x20,0 (x11)		# output data #load to 11
		
		lw	x20,0 (x10)		# input data #load from 10	
		lw	x21,0 (x10)		# input data #load from 10	
		add	x20,x20,x21		# add input value
		sw	x20,0 (x12)		# output data #load to 12
		
		j	my_prog			# Corrected to my_prog to complete loop  	
		
