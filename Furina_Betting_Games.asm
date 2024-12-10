.data
gameTable:.word gameCoin, gameDice # Implementation of arrays

errorLine1:.asciiz "That's not a game..."
errorLine2:.asciiz "Stop messing with me! " # The game would just crash if a player enters a non-integer, so this is unused
errorLine3:.asciiz "A negative bet? Did you hit your head or...?\n\n"
errorLine4:.asciiz "You don't even have that much, hmph! Try again!\n\n"
errorLine5:.asciiz "You can only enter 0 or 1, fufu~ Try again!\n\n"
gameStart1:.asciiz "Welcome to the Furina Betting Games. Your current balance is: "
gameStart2:.asciiz " Furidollars.\n0: Double or Nothing Coin flip (You're heads)."
gameStart3:.asciiz "\n1: Dice Difference game with adjustable betting. Pick a game: "
gameCoin1:.asciiz "Flipping your coin... It landed on "
gameCoin2:.asciiz "Heads"
gameCoin3:.asciiz "Tails"
gameCoin4:.asciiz "!\nYou won! Your balance is doubled! You may now rejoice in this!\n\n"
gameCoin5:.asciiz "!\nYou lost. What's done is done~.\n\n"
gameDice1:.asciiz "How much do you want to bet: "
gameDice2:.asciiz "\n0: Lower than 3\n1: Higher than 2\nHurry up and pick a number: "
gameDice3:.asciiz "\nYour dice rolled: "
gameDice4:.asciiz " and "
gameDice5:.asciiz ". Their difference is "
gameDice6:.asciiz "\nI can't believe you won... ugh... good job!\n\n"
gameDice7:.asciiz "\nWueheheh, you lost again!\n\n"
gameOver1:.asciiz "Thank you for playing! I will now invest this money into Fontinalia Mousses~"
line_down:.asciiz "\n"

.text
main:
	li $s0, 0x10010020 # Address of Furidollars 
	li $t0, 500 # Let the player start with 500 Furidollars 
	sw $t0, ($s0) # Store those Furidollars 
	j mainGameLoop
	
	
mainGameLoop:
	lw $t0, ($s0) # Load Furidollars into register t0
	beqz $t0, gameOver # If the player has 0 coins, jump to gameOver
	
	li $v0, 4 # Print string instruction
	la $a0, gameStart1 # First argument is 'gameStart1' String
	syscall
	li $v0, 1 # Print integer instruction
	lw $a0, ($s0) # Get number of Furidollars
	syscall
	li $v0, 4 # Print string instruction
	la $a0, gameStart2 
	syscall
	la $a0, gameStart3
	syscall
	
	li $v0, 5 # Get player game choice (integer-only)
	syscall
	move $t1, $v0 # Load player choice into register t1
	
	li $v0, 4 # Print string instruction
	la $a0, line_down # Just to make the CLI prettier
	syscall
	
	bltz $t1, errorGameNotAvailable # If the input is negative, jump to error label 0
	bgt $t1, 1, errorGameNotAvailable # If the input is higher than 1, jump to error label 0
	la $a0, gameTable # Load address of the first game label (gameCoin)
	sll $t1, $t1, 2 # Multiply by 4 (By bit-shifting to the left by 2) to get desired array element's separation
	add $a0, $a0, $t1 # Desired array element address
	lw $t1, 0($a0)
	jr $t1 # Go to chosen game (Jr is jumping to the address at register, while j jumps to the address or label itself)
	
	
gameCoin:
	li $v0, 4 # Print string instruction
	la $a0, gameCoin1
	syscall
	
	li $v0, 42 # Generate a random integer
	li $a1, 2 # Between 0-1 and return to $a0
	syscall
	beqz $a0, gameCoinWin # If random number is 0, jump to win. Otherwise, lose.
	j gameCoinLose
	
	
gameCoinWin:
	lw $t0, ($s0) # Load Furidollars into register t0
	sll $t0, $t0, 1 # Multiply currency by 2 (By bit-shifting to the left by 1)
	sw $t0, ($s0)
	
	li $v0, 4 # Print string instruction
	la $a0, gameCoin2
	syscall
	li $v0, 4 # Print string instruction
	la $a0, gameCoin4
	syscall
	j mainGameLoop


gameCoinLose:
	sw $zero, ($s0)
	
	li $v0, 4 # Print string instruction
	la $a0, gameCoin3
	syscall
	li $v0, 4 # Print string instruction
	la $a0, gameCoin5
	syscall
	j mainGameLoop


gameDice:
	lw $t0, ($s0) # Load Furidollars into register t0
	
	li $v0, 4 # Print string instruction
	la $a0, gameDice1 
	syscall
	
	li $v0, 5 # Get player bet amount (integer-only)
	syscall
	move $t1, $v0 # Load player choice into register t1
	
	bltz $t1, errorNegativeBet # If the bet amount is negative, jump to error line 2
	bgt $t1, $t0, errorBetTooHigh # If the bet amount is higher than current Furidollars, jump to error line 3
	
	
	li $v0, 4 # Print string instruction
	la $a0, gameDice2
	syscall
	
	li $v0, 5 # Get player bet choice (integer-only)
	syscall
	move $t2, $v0 # Load player choice into register t2
	
	bltz $t2, errorDiceBetChoice # If the bet choice is negative, jump to error line 4
	bgt $t2, 1, errorDiceBetChoice # If the bet choice is higher than 1, jump to error line 4
	
	li $v0, 42 # Generate a random integer
	li $a1, 6 # Between 0-5 and return to $a0
	syscall
	addi $t3, $a0, 1 # Dice 1 result in $t3
	syscall 
	addi $t4, $a0, 1 # Dice 2 result in $t4
	subu $t5, $t3, $t4 # Get its difference into $t5
	# Then get its absolute value into $t5
	sra $t6,$t5,31 
	xor $t5,$t5,$t6   
	sub $t5,$t5,$t6
	
	li $v0, 4 # Print string instruction
	la $a0, gameDice3
	syscall
	li $v0, 1 # Print integer instruction
	la $a0, ($t3)
	syscall
	
	li $v0, 4 # Print string instruction
	la $a0, gameDice4
	syscall
	li $v0, 1 # Print integer instruction
	la $a0, ($t4)
	syscall
	
	li $v0, 4 # Print string instruction
	la $a0, gameDice5
	syscall
	li $v0, 1 # Print integer instruction
	la $a0, ($t5)
	syscall
	
	blt $t5, 3, gameDiceLessThan3
	j gameDiceGreaterThan2


gameDiceLessThan3:
	beq $t2, 0, gameDiceWin # If player bet choice is 0, jump to win. Else, lose.
	j gameDiceLose
	
	
gameDiceGreaterThan2:
	beq $t2, 1, gameDiceWin # If player bet choice is 1, jump to win. Else, lose.
	j gameDiceLose


gameDiceWin:
	addu $t0, $t0, $t1
	sw $t0, ($s0)
	li $v0, 4 # Print string instruction
	la $a0, gameDice6
	syscall
	j mainGameLoop
	

gameDiceLose:
	subu $t0, $t0, $t1
	sw $t0, ($s0)
	li $v0, 4 # Print string instruction
	la $a0, gameDice7
	syscall
	j mainGameLoop
	

errorGameNotAvailable:
	li $v0, 4 # Print string instruction
	la $a0, errorLine1
	syscall
	li $v0, 4 # Print string instruction
	la $a0, line_down # Just to make the CLI prettier
	syscall
	syscall
	j mainGameLoop


errorNegativeBet:
	li $v0, 4 # Print string instruction
	la $a0, errorLine3
	syscall
	j mainGameLoop


errorBetTooHigh:
	li $v0, 4 # Print string instruction
	la $a0, errorLine4
	syscall
	j mainGameLoop


errorDiceBetChoice:
	li $v0, 4 # Print string instruction
	la $a0, errorLine5
	syscall
	j mainGameLoop


gameOver:
	li $v0, 4 # Print string instruction
	la $a0, gameOver1 # First argument is 'msg' String
	syscall
	
	li $v0, 10 # Exits program
	syscall
