#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int main() {
  int balance = 500;
  int gameChoice = -1;
  while (balance > 0) {
    srand((int)time(0)); // Seed randomness into rand() functions
    printf("Welcome to the Furina Betting Games. Your current balance is %d "
           "Furidollars.",
           balance);
    printf("\n0: Double or Nothing Coin flip (You're heads).");
    printf("\n1: Dice Difference game with adjustable betting. Pick a game: ");
    int result = scanf("%d", &gameChoice);
    if (!result) {
      while (getchar() != '\n')
        ;
      printf("Read the damn instructions! Ugh...\n\n");
      continue;
    }

    // Exception handling
    switch (gameChoice) {
    case 0:
      gameChoice = 0;
      break;
    case 1:
      gameChoice = 1;
      break;
    default:
      printf("That isn't an available game, c\'mon!");
      continue;
    }

    if (gameChoice) {
      // Generates a random integer between 1 and 6 for both dice, then get
      // their difference
      int betAmount, betChoice, dice1 = rand() % 6 + 1, dice2 = rand() % 6 + 1,
                                diff = abs(dice1 - dice2);
      printf("How much do you want to bet: \n");
      scanf("%d", &betAmount);

      // Exception handling
      if (betAmount > balance) {
        printf("You don't even have that much, hmph! Try again!\n\n");
        continue;
      }
      if (betAmount < 0) {
        printf("A negative bet? Did you hit your head or...?\n");
        continue;
      }

      printf(
          "0: Lower than 3\n1: Higher than 2\nHurry up and pick a number: \n");
      scanf("%d", &betChoice);

      // Exception handling
      switch (betChoice) {
        case 0: betChoice = 0; break;
        case 1: betChoice = 1; break;
        default: printf("You can only enter 0 or 1, fufu~ Try again!\n\n"); continue;
      }

      // Game 2's Logic
      printf("Your dice rolled: %d and %d. Their difference is %d\n", dice1,
             dice2, diff);
      if ((betChoice == 0 && diff < 3) || (betChoice == 1 && diff > 2)) {
        balance += betAmount;
        printf("I can't believe you won... ugh... good job!\n\n");
      } else {
        balance -= betAmount;
        printf("Wueheheh, you lost again!\n\n");
      }
    } else {
      // Game 1's Logic
      int ran = rand() % 2; // Generates a random integer between 0 and 1

      if (ran == 0) {
        printf("Flipping your coin... It landed on Heads!\n");
        balance *= 2;
        printf("You won! Your balance is doubled! You may now rejoice in "
               "this~\n\n");
      } else {
        printf("Flipping your coin... It landed on Tails!\n");
        balance = 0;
        printf("You lost. What's done is done~.\n\n");
      };
    }
  }
  printf("Thank you for playing! I will now invest this money into Fontinalia "
         "Mousses~");
  return 0;
}
