using System;
//using 500 years of trauma;

namespace C_Sharp_Speedrun1
{
    class Program
    {
        static ulong balance = 500; //Stores up to 18,446,744,073,709,551,615
        static Random rnd = new Random(); //Seed randomness into rnd.Next() functions

        static string[] errorLines = 
        {
            "That isn't an available game, c\'mon!",
            "Stop messing with me!",
            "A negative bet? Did you hit your head or...?",
            "You don't even have that much, hmph! Try again!",
            "You can only enter 0 or 1, fufu~ Try again!"
        };
        static void errorType(int errorIndex) { Console.Write(errorLines[errorIndex] + "\n\n"); } //Throw a specific error message and make a new line
        
        static ulong handleGameCoinflip(ulong balance)
        {
            int rand = rnd.Next(0, 2); //Generate a random integer between 0 and 1
            
            string coin = (rand == 0) ? "Heads" : "Tails";
            string finisher = (rand == 0) ?  "You won! Your balance is doubled! You may now rejoice in this!" : "You lost. What's done is done~.";
            Console.Write($"Flipping your coin... It landed on {coin}!\n{finisher}\n\n");

            balance = (rand == 0) ? balance * 2 : 0;
            return balance;
        }
        static ulong handleGameDice(ulong balance)
        {   //Generates a random integer between 1 and 6 for both dice, then get their difference
            int dice1 = rnd.Next(1, 7), dice2 = rnd.Next(1, 7), diff = Math.Abs(dice1 - dice2); 

            ulong betAmount;
            Console.Write("How much do you want to bet: ");
            try { betAmount = Convert.ToUInt64(Console.ReadLine().Trim()); } //Get betAmount from user and Exception Handling
            catch { errorType(1); return balance; }
            if (betAmount < 0) { errorType(2); return balance; }
            if (betAmount > balance) { errorType(3); return balance; }

            int betChoice;
            Console.Write("\n0: Lower than 3\n1: Higher than 2\nHurry up and pick a number: ");
            string input = Console.ReadLine().Trim();
            switch (input) //Exception handling for betChoice
            {
                case "0": betChoice = 0; break;
                case "1": betChoice = 1; break;
                default: errorType(4); return balance;
            }

            //Game 2's Results
            Console.Write($"\nYour dice rolled: {dice1} and {dice2}. Their difference is {diff}\n");
            if ((betChoice == 0 && diff < 3) || (betChoice == 1 && diff > 2))
            {
                balance += betAmount;
                Console.Write("I can't believe you won... ugh... good job!\n\n");
            }
            else
            {
                balance -= betAmount;
                Console.Write("Wueheheh, you lost again!\n\n");
            }
            return balance;
        }
        static bool mainGameLoop(ulong balance)
        {
            while (balance > 0)
            {
                Console.Write($"Welcome to the Furina Betting Games. Your current balance is: {balance} Furidollars.");
                Console.Write("\n0: Double or Nothing Coin flip (You're heads).");
                Console.Write("\n1: Dice Difference game with adjustable betting. Pick a game: ");

                string gameChoice = Console.ReadLine().Trim();
                switch (gameChoice)
                {
                    case "0": balance = handleGameCoinflip(balance); break;
                    case "1": balance = handleGameDice(balance); break;
                    default: errorType(0); continue;
                }
                if (balance == 182376)
                {
                    return false;
                }
            }
            return true;
        }

        static void Main(string[] args)
        {
            bool happy = mainGameLoop(balance);
            if (happy) { NormalEnding(); }
            else { MentalBreakdown(); }
        }
        static void NormalEnding() { Console.Write("Thank you for playing! I will now invest this money into Fontinalia Mousses~"); }
        static void MentalBreakdown()
        {
            //Stare(quivering);
            //Cry(slowly, silently);
            //PTSD();
            Console.Write("...why?");
        }
    }
}
