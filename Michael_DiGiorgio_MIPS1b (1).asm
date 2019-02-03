# 	1) Name: Michael DiGiorgio
#  	   Last date modified: 5/11/2017
#	   MIPS1b
#	2) This program will use a for loop that starts at j= 20 and iterates down by until it reaches 10 and then stops. On each pass, j is printed,
#	   followed by j + an integer the user is prompted enter. The user inputs an integer and the program iterates until j is no longer
#	   greater than 10 and then stops
#
#	Scanner input = new Scanner(System.in)
#	System.out.println("Input a value to be used as a constant and added to each entry of loop")
#	String name = userInputScanner.nextLine();

#	int constant =
#	for(int j=20; j>10; j--){
#	total = j + constant;
#	println(�for j equal � +j + �, total equal � + total); }  <------ Main loop

#	3)
#	   $v0 = returned values that are then stored elsewhere, such as from prompts
#	   $a0 = the address where the "prompt" string are stored are loaded here
#	   $s0 = this register is initialized to 20, which represents j
#	   $s1 = this register is initialized to 10, which our j is compared to each iteration of the loop
#	   $s2 = the user's input is placed here to be added to j
#	   $zero = values added here to the empty register to be added to other registers when "add" is used



.data

	prompt: .asciiz "Input a value to be used as a constant and added to each entry in the loop: "
	jMessage: .asciiz "\n For j equal "
	totalMessage: .asciiz ", the total is equal to "

.text

# "main" initializes some starting values of j and what we will compare each iteration to, as well as prompting the user for the input of a constant
	main:

	li $s0 20  #initialize $s0 to 20,
	li $s1 11  #initialize $s1 to 11

	#Prompt user to input a constant number

	li $v0, 4
	la $a0, prompt
	syscall

	#Get the number from the keyboard
	li $v0, 5
	syscall

	#Store the number in $s2

	add $s2, $zero, $v0
	j message1 #This prints the first part of the message with $s0 value
	j message2 #This prints the second part with the $s0 + $s2 value, which was the constant number input by the user
	j check    #Refers back to check function


#This will check if $s1 < $s0 (or, is 10 less than 20) as the counter goes down from 20, and if it is, go to "loop" and subtract 1 from $s0
	check:

	slt $t0, $s1, $s0, #If $s1 is less than $s0, make the vaule of $t0 equal 1, or "true"
	beq $t0, 1, loop   #Use branch-equal to see if the value of $t0 is 1, if so, go to "loop" function
	beq $s0, $s1, end  #If the number in $s0 and $s1 become the same, end the program

#This function takes $s0, which is initialized to 20, and reduces it by 1 if the value of $t1 is 1

	loop:

	addi $s0, $s0, -1 #Adds -1 to $s0 at each pass though

	j message1 #Prints again but after iteration
	j message2 #Prints after iteration
	j check    #Check condition

	message1:
	li $v0, 4
	la $a0, jMessage
	syscall

	li $v0, 1
	add $a0, $zero, $s0
	syscall

	message2:
	li $v0, 4
	la $a0, totalMessage
	syscall

	li $v0, 1
	add $a0, $s2, $s0
	syscall

	j check #Back to check function

#When the condition of j no longer being greater than 0 is met, the program ends
	end:

	li $v0, 10
	syscall
