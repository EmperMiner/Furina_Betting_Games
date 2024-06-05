from random import randrange
balance = 500

while(balance > 0):
    print(f"Welcome to the Furina Betting Games. Your current balance is {balance} Furidollars.")
    print("0: Double or Nothing Coin flip (You're heads).")
    gameChoice = input("1: Dice Difference game with adjustable betting. Pick a game: ")

    #Exception handling
    match gameChoice:
        case "0": #Game 1's Logic
            ran = randrange(2)
            #Set balance and display text in the case that 'ran' is 0
            balance *= 2 if ran == 0 else 0
            coin = "Heads" if ran == 0 else "Tails"
            resultText = "You won! Your balance is doubled! You may now rejoice in this~\n" if ran == 0 else "You lost. What's done is done~.\n"
            print(f"Flipping your coin... It landed on {coin}!", resultText)
        case "1": #Game 2's Logic
            betAmount, dice1, dice2 = 0, randrange(6) + 1, randrange(6) + 1 #Generate a random integer between 1 and 6 for both dice
            diff = abs(dice1 - dice2)

            #Exception handling
            while (betAmount > balance or betAmount < 0):
                try:
                    betAmount = int(input("How much do you want to bet: "))
                except:
                    print("A negative bet? Did you hit your head or...?\n") if betAmount < 0 else print("You don't even have that much, hmph! Try again!\n\n")

            betChoice = input("0: Lower than 3\n1: Higher than 2\nHurry up and pick a number: ")
            #Exception handling
            match betChoice:
                case "0": betChoice = 0
                case "1": betChoice = 1
                case _:    
                    print("You can only enter 0 or 1, fufu~ Try again!\n")
                    pass

            print(f"Your dice rolled: {dice1} and {dice2}. Their difference is {diff}")
            if ((betChoice == 0 and diff < 3) or (betChoice == 1 and diff > 2)):
                balance += betAmount
                print("I can't believe you won... ugh... good job!\n")
            else:
                balance -= betAmount
                print("Wueheheh, you lost again!\n")    
        case _: 
            print("That isn't an available game, c\'mon!\n")
            pass

print("Thank you for playing! I will now invest this money into Fontinalia Mousses~")