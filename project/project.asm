#Name: Ajani Stewart
#CSci 260
#March 26, 2019


.data
frameBuffer: .space 0x80000 			#512 x 256 pixels
n:	     .word  40
m: 	     .word  50


.text
# Allocate s0 <- n, s1 <- m
init:       
      la	  $t1, frameBuffer
	    addi  $t2, $t1, 0x80000		# t2 <- the end of the thing
      li	  $t3, 0x000FFFF00 		# $t3 = yellow
      la 	  $s0, n			        #load address of n
      la    $s1, m			        #load address of m
      lw    $s0, 0($s0)         #s0 <- n
      lw	  $s1, 0($s1)         #s1 <- m
      
      sll   $t0, $s1, 1			#t0 <- 2m
      add   $t0, $t0, $s0			#t0 <- 2m+n
      slti  $t4, $t0, 0x100		#t4 <- 1 if 2m+n < 256; else 0
      beq   $t4, $zero, exit		#exit if the dimensions a3re invalid
      
      addi  $s0, $s0, 1			#increment n
      andi  $s0, $s0, 0x7FFE		#keep all but the least significant bit
      
      addi  $s1, $s1, 1			#increment m
      andi  $s1, $s1, 0x7FFE		#keep all but least significant bit
            
loopYellow: 
      sw    $t3, 0($t1)               #color pixel
      addi  $t1, $t1, 4               #move to the next piel
      bne   $t1, $t2, loopYellow 	    #color background yellow
      li 	  $t3, 0x0000000FF	        # change color to blue for rectangles	 
	    
vRectInit:  
      sll   $t4, $s0, 10			#t4 <- 1024n
	    li	  $t5, 0x40000			#t4 <- 0x40000
	    sll   $t6, $s1, 11	    		#t6 <- 2048m, move down the correct amount
	    sub   $t4, $t5, $t4			#t4 <- 0x40000 - 1024n
	    sub   $t4, $t4, $t6			#t4 <- 0x40000 - 1024n - 2048m
	    li    $t5, 0x400			#t5 <- 1024
	    sll   $t6, $s0, 1			#t6 <- 2n
	    sub   $t5, $t5, $t6			#t5 <- 1024 - 2n
	    add   $s2, $t4, $t5			#s2 is top left of rect (start pos)
	    
	   
	    
	    
	    sll   $t4, $s0, 2			#t4 <- 4n
	    add   $s3, $t4, $s2			#s3 <- start pos + 4n
	    sll	  $t4, $s0, 11			#t4 <- 2048n
	    add   $s3, $s3, $t4			#s3 <- start pos + 4n + 2048n
	    sll	  $t4, $s1, 12			#t4 <- 4096m
	    add   $s3, $s3, $t4			#s3 <- offset to end pos of rect from start pos
	    addi  $t1, $t1, -0x80000		#reset frame buffer
	    move  $t7, $t1			#t7 <- t1
	    add   $t1, $t1, $s2			#move to top left corner of rectangle
	    add   $s3, $s3, $t7			#s3 <- bottom right corner of rect
	    add   $t4, $zero, $zero		#t4 <- 0, will be used as counter for innerloop
	    add	  $t9, $zero, $zero		#t9 <- 0, will be used as counter for outer loop
	    sll   $t5, $s0, 2			#t5 <- 4n
	    
	    
fillVRect:
	    sw    $t3, 0($t1)			#color pixel blue
	    addi  $t1, $t1, 4			#go to next pixel
	    addi  $t4, $t4, 4			#increment counter
	    bne   $t4, $t5, fillVRect		#loop
	    sub   $t1, $t1, $t5			#move t1 to the left edge of rectangle
	    addi  $t1, $t1, 0x800		#go to next line
	    addi  $t9, $t9, 1			#increment outer loop counter
	    move  $t4, $zero			#reset counter to 0
	    bne   $t9, $t0, fillVRect		#finish when the lower left corner is reached
	    
	    
	    
hRectInit:
	   la  $t1, frameBuffer		 	#reset frame buffer
	   
	   li    $t4, 0x40000			#t4 <- 0x40000
	   sll   $t5, $s0, 10			#t5 <- 1024n
	   sub   $t5, $t4, $t5			#t5 <- 0x40000 - 1024n
	   
	   li    $t4, 0x400			#t4 <- 0x400
	   sll   $t2, $s0, 1			#t2 <- 2n
	   sub   $t2, $t4, $t2			#t2 <- 0x400 - 2n
	   sll   $t6, $s1, 2			#t6 <- 4m
	   sub 	 $t2, $t2, $t6			#t2 <- 0x400 - 2n - 4m
	   add	 $t2, $t2, $t5			#t2 <- correct offest to start pos
	   add	 $t1, $t1, $t2			#t1 is at the correct position (I hope)
	   
	   move  $t4, $zero			#initialized t4 to 0; counter for inner loop
	   move  $t5, $zero			#initialized t5 to 0; counter for outer loop
	   sll   $t6, $t0, 2			#t6 <- 4(2m+n), upper bound for inner loop

	   
fillHRect:
	   sw    $t3, 0($t1)			#color pixel blue
	   addi  $t1, $t1, 4			#move to the next pixel
	   addi	 $t4, $t4, 4			#increment inner counter loop
	   bne   $t4, $t6, fillHRect		#loop if we havent finished the row
	   sub   $t1, $t1, $t6			#move back to the left edge of the rectangle
	   addi  $t1, $t1, 0x800		#go to the next line
	   move  $t4, $zero			#reset inner counter
	   addi  $t5, $t5, 1			#increment outer loop
	   bne   $t5, $s0, fillHRect		#loop if entire rectangle is not finished yet
	
	    		     
exit:       
     li    $v0, 10
     syscall
          
# yellow is 0x000FFFF00
# blue is 0x0000000FF


#step 1, draw a yellow back ground
#step 2, draw a vertical blue rectangle
#step 3, draw a horizontal blue rectangle identical to the previous one
#step 4, ???
#step 5, get a good grade in the class