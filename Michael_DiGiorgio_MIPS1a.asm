# 	1) Name: Michael DiGiorgio
#  	   Last date modified: 5/11/2017
#	   MIPS1a
#	2) This program takes in two integers from the user, the first integer between the range of -10 to 0, which is enforced by the program
#	   and a second integer which will be between the values 10 and 20. The first integer will be multiplied by 4 and then added to the second integer
#	   The program will loop repeatedly after the user enters both values. A sentinel is given of -999 to exit the program.

#	Scanner input = new Scanner(System.in)
#	System.out.println("Enter a number between -10 and 0, which will be multiplied by 4 (Enter -999 to exit program): \n")
#	String name = userInputScanner.nextLine();


#	int a, int b;
#	int c = (4*a) + b;
#	if (a < -10 || a > 10)
#	   system.out.prinln "First number is out of range";
#	if (b < 10 || b > 20)
#		system.out.println "Second number is out of range";
	

#	3) $t1 = -10
#	   $t2 = 0
#	   $t3 = 10
#	   $t4 = 20
#	   $t5 = -999
#	   $v0 = returned values that are then stored elsewhere
#	   $a0 = the address where a the "prompt" string are stored are loaded here
#	   $s0 = result of prompt1 * 4 is stored here
#	   $s1 = result of prompt2 is stored here
#	   $s2 = the sum of $s0 and $s1 added
#	   $zero = values added here to the empty register to be added to other registers when "add" is used


.data
	prompt1: .asciiz "\nEnter a number between -10 and 0, which will be multiplied by 4 (Enter -999 to exit program): \n" 
	prompt2: .asciiz "Enter another number, this time between 10 and 20(Enter -999 to exit program): \n "
	message: .asciiz "The two numbers added together are: \n" 


.text 

# The main function here initializes some values (including a sentinel value of -999 to exit the program) and links to two functions, 1 and 2
	main:
		addi $t1, $zero, -10
		addi $t2, $zero, 0
		
		addi $t3, $zero, 10
		addi $t4, $zero, 20
		
		addi $t5, $zero, -999
		
		j number1
		j number2
		
# Function number 1 prompts the user to enter in a number between -10 and 0, which then calls a "check1" function
	number1:
		#Prompt1
		li $v0, 4
		la $a0, prompt1
		syscall
		
		#Get the number
		li $v0, 5
		syscall

		j check1
	
# The "check1" function uses slt to compared the values declared in the $t registers to the inputs. beq is utilized to refer back to the function
# to request a correct input again. If it is good, the number is multiplied by 2^2 using the sll command and stored
	check1:
		beq $v0, $t5, end
		
		slt $t0, $v0, $t1	#$t1 is -10
		beq $t0, 1, number1
		
		slt $t0, $t2, $v0	#$t2 is 0
		beq $t0, 1, number1
		
		
		sll $s0, $v0, 2

# number2 is the same as number1 except it also calls an "add" function to combine both inputs. The check2 command that it links to contains
# the function contains a command to add the user's second input to a register to us in the "add" function.
	number2:
		li $v0, 4
		la $a0, prompt2 
		syscall
		
		#Get the number
		li $v0, 5
		syscall
		
		j check2
		j addNumbers
		
	check2:
		beq $v0, $t5, end
		
		slt $t0, $v0, $t3	#$t3 is 10
		beq $t0, 1, number2
		
		slt $t0, $t4, $v0	#$t4 is 20
		beq $t0, 1, number2
		
		add $s1, $zero, $v0
	
# "add" combines the two inputs by placing them in $s2, then refers to the function "display" to display them
	addNumbers:
		add $s2, $s0, $s1
		j display
		
# "display" simply loads the value of $s2 to be displayed, and this function also calls main, since it is supposed to run on an endless loop
# prompting the user until they input the sentinel command
	display:
		li $v0, 4
		la $a0, message 
		syscall
		
		li $v0, 1
		add $a0, $zero $s2
		syscall
		
		jal main
	
	end:
	
		li $v0, 10
		syscall
	
		
		
	
