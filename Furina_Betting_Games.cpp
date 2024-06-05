#include <iostream>
#include <time.h>
#include<sstream>
#include <string>
using namespace std;

//Ivan's code
int userInputAsUnsignedInt() {
    std::string line = "";
    int input = 0, flag = 0;
    while (flag < 2) {
        
    std::getline(std::cin, line);
    std::stringstream ss(line);
    
        if (flag == 1){
            if ((ss >> input)) { flag = 2; }
            else { cout<<"Stop messing with me! Enter an actual whole number: "; }
        }
        if (flag == 0) { flag = 1; }
    }
    return input;
}

int main()
{   
    int balance = 500, gameChoice;
    while(balance > 0) {
        srand((int)time(0)); //Seed randomness into rand() functions
        cout<<"Welcome to the Furina Betting Games. Your current balance is "<< balance << " Furidollars.";
        cout<<"\n0: Double or Nothing Coin flip (You're heads).";
        cout<<"\n1: Dice Difference game with adjustable betting. Pick a game: ";
        cin>>gameChoice;
        
        //Exception handling
        switch(gameChoice){
		    case 0: gameChoice = 0; break;
		    case 1: gameChoice = 1; break;
		    default: cout<<"That isn't an available game, c\'mon!\n\n"; continue;
	    }

        if (gameChoice) {
            //Generates a random integer between 1 and 6 for both dice, then get their difference
            int betAmount, betChoice, dice1 = rand() % 6 + 1, dice2 = rand() % 6 + 1, diff = abs(dice1 - dice2); 
            cout<<"How much do you want to bet: ";
            betAmount = userInputAsUnsignedInt();
            
            //Exception handling
            if (betAmount > balance) { 
                cout<<"You don't even have that much, hmph! Try again!\n\n";
                continue;
            }
            if (betAmount < 0) { 
                cout<<"A negative bet? Did you hit your head or...?\n\n";
                continue;
            }
            
            cout<<"0: Lower than 3\n1: Higher than 2\nHurry up and pick a number: \n";
            cin>>betChoice;

            //Exception handling
            switch(betChoice)   {
                case 0: betChoice = 0; break;
                case 1: betChoice = 1; break;
                default: cout<<"You can only enter 0 or 1, fufu~ Try again!\n\n"; continue;
	        }

            //Game 2's Logic
            cout<<"Your dice rolled: "<<dice1<<" and "<<dice2<<". Their difference is "<<diff<<"\n";
            if((betChoice == 0 && diff < 3) || (betChoice == 1 && diff > 2)) {
                balance += betAmount;
                cout<<"I can't believe you won... ugh... good job!\n\n";
            }
            else {
                balance -= betAmount;
                cout<<"Wueheheh, you lost again!\n\n";
            }
        }
        else {
            //Game 1's Logic
            int ran = rand() % 2; //Generates a random integer between 0 and 1
            string coin = "Heads";
            if (ran == 1) { coin = "Tails"; }
            cout<< "Flipping your coin... It landed on "<< coin << "!\n";
            
            if (ran == 0) { 
                balance *= 2;
                cout<<"You won! Your balance is doubled! You may now rejoice in this~\n\n";
            }
            else {
                balance = 0;
                cout<<"You lost. What's done is done~.\n\n";
            };
        }
    }
    cout<<"Thank you for playing! I will now invest this money into Fontinalia Mousses~";
    return 0;
}