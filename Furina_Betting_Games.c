#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <stdint.h>


int main() { // Less readable, and shorter.
    int64_t balance = 500; // Let the players start with 500 Furidollars
    while (balance > 0) {
        srand((int)time(0)); // Seed randomness into rand() functions
        printf("Welcome to the Furina Betting Games. Your current balance is "
                "%lu Furidollars.", balance);
        printf("\n0: Double or Nothing Coin flip (You're heads).\n");
        printf("1: Dice Difference game with adjustable betting. Pick a game: ");
        
    int gameChoice;
    int result = scanf("%d", &gameChoice);
    if (!result) { // If the player inputs anything other than the specified 
        while (getchar() != '\n') // data type, they will get roasted.
            ;
        printf("\nRead the damn instructions! Ugh...\n\n");
        continue;
    }
    switch (gameChoice) { // Exception handling
        case 0: gameCoin(&balance); break;
        case 1: gameDice(&balance); break;
        default: printf("That isn't an available game, c\'mon!\n\n"); continue;}
  }
  printf("Thank you for playing! I will now invest this money into Fontinalia "
         "Mousses~");
  return 0;
}


void gameCoin(int64_t *p_balance) {
    if (rand() % 2) { // Generates a random integer between 0 and 1
        printf("Flipping your coin... It landed on Heads!\n");
        *p_balance *= 2;
        printf("You won! Your balance is doubled! You may now rejoice in "
               "this~\n\n");
    } else {
        printf("Flipping your coin... It landed on Tails!\n");
        *p_balance = 0;
        printf("You lost. What's done is done~.\n\n"); }
}


void gameDice(int64_t *p_balance) {
    // Generates a random int from 1-6 for 2 dice, then get their difference
    int dice1 = rand() % 6 + 1, dice2 = rand() % 6 + 1, diff = abs(dice1-dice2); 
        
    int64_t betAmount;
    printf("How much do you want to bet: ");
    scanf("%lu", &betAmount);
    if (betAmount > *p_balance) { // Exception handling
        printf("You don't even have that much, hmph! Try again!\n\n"); return;
    } else if (betAmount < 0) {
        printf("A negative bet? Did you hit your head or...?\n\n"); return; }

    int betChoice;
    printf("0: Lower than 3\n1: Higher than 2\nHurry up and pick a number: ");
    scanf("%d", &betChoice);
    if (betChoice != 0 && betChoice != 1) { // Exception handling
        printf("You can only enter 0 or 1, fufu~ Try again!\n\n"); return; }

    printf("Your dice rolled: %d and %d. Their difference is %d\n", 
            dice1, dice2, diff);
    if ((betChoice == 0 && diff < 3) || (betChoice == 1 && diff > 2)) {
        *p_balance += betAmount;
        printf("I can't believe you won... ugh... good job!\n\n");
    } else {
        *p_balance -= betAmount;
        printf("Wueheheh, you lost again!\n\n"); }
}
