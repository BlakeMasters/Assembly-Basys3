 #   //- INPUT PORT IDS ---------------------------------------------------------
#    localparam SWITCHES_PORT_ADDR = 32'h11008000;  // 0x1100_8000
#    localparam BUTTONS_PORT_ADDR  = 32'h11008004;  // 0x1100_8004                 
#    //- OUTPUT PORT IDS --------------------------------------------------------
#    localparam LEDS_PORT_ADDR     = 32'h1100C000;  // 0x1100_C000
#    localparam SEGS_PORT_ADDR     = 32'h1100C004;  // 0x1100_C004
#    localparam ANODES_PORT_ADDR   = 32'h1100C008;  // 0x1100_C008
6_programming:

init:
	li	x2, 0x11008004		#Store Button output address to reg
	li	x3, 0x1100C000		#Store LED output addr to reg
	
	mv	x15, x0			#Led outputs to known 0
	sw	x15, 0(x3)		#led val to led addr
	
infinite_blink:	
		j	first		#bypass check
notfirst:	
		bne	x30,x0,notfirst		#loops until you release button
first:
		lw	x30, 0(x2)	#button value
		andi	x30,x30,1	#mask
		bne	x30,x0,buttonLeft	#move to interrupt when button press is 1
		
isButton:	li	x15,1			#led high
		sw	x15, 0(x3)		#store on
		call	delay_ff
		li	x15,0			#led low
		sw	x15, 0(x3)		#store off
		j	infinite_blink		#blink back
	
#------------------------------------------------------------
# Branch Response: buttonLeft
#
# For Button Pressed, set blinking leds from right to left
#Returns to notfirst
# tweaked registers: x15,x10,x11
#------------------------------------------------------------		
buttonLeft:
	li	x15,1			#set led val to high
	li	x10,30			#loop count for 16 leds
	li	x11,15			#loop for return
#store led
	
loop_leds:
	beq	x10,x11,loop_back	#if at led left, start the blink back
	sw	x15,0(x3)		#store led val to led addr
	call	delay_ff		#subroutine delay
loopAdmin:
	slli	x15,x15,1		#Next led left
	addi	x10,x10,-1		#loop down
	j	loop_leds		#ret loop

loop_back:
	beqz	x10,notfirst		#checking if done. to button off check
	sw	x15,0(x3)		#store led val to led addr
	call	delay_ff		#delay
loopAdmin:
	srli	x15,x15,1		#Next led right
	addi	x10,x10,-1		#loop down
	j	loop_back		#ret loop
#------------------------------------------------------------


#------------------------------------------------------------
# Subroutine: delay_ff
#
# Delays for a count of FF. Unknown how long that is but it
# is plenty of time for display multiplexing
#
# tweaked registers: x31
#------------------------------------------------------------
delay_ff: 
 	li 	x31,0xFF 	# load count
loop: 
	beq 	x31,x0,done 	# leave if done
 	addi 	x31,x31,-1 	# decrement count
 	j	loop 		# rinse, repeat
done:	ret 			# leave it all behind
#-------------------------------------------------------------


