//Apparently, getting user input with prompt() doesn't work in VSCode, so this code only works in a browser
//Otherwise, it is almost identical to C# in terms of syntax, with the exclusion of types. I wonder what Typescript is like...
function handleGameCoinflip(balance) {
    let rand = Math.floor(Math.random() * 2); //Generate a random integer between 0 and 1
    
    let coin = (rand === 0) ? "Heads" : "Tails";
    let finisher = (rand === 0) ? "You won! Your balance is doubled! You may now rejoice in this!" : "You lost. What's done is done~.";
    console.log("Flipping your coin... It landed on " + coin + "!\n" + finisher + "\n");
    return balance = (rand == 0) ? balance * 2 : 0;
}

function handleGameDice(balance) {
    //Generates a random integer between 1 and 6 for both dice, then get their difference
    let dice1 = Math.floor(Math.random() * 6) + 1, dice2 = Math.floor(Math.random() * 6) + 1, diff = Math.abs(dice1 - dice2); 
    
    let betAmount = 0
    //Exception Handling
    try { betAmount = parseInt(prompt("How much do you want to bet: ")); }
    catch (err) { console.log("Stop messing with me!\n"); return balance; }
    if (betAmount > balance) { console.log("You don't even have that much, hmph! Try again!\n"); return balance; }
    if (betAmount < 0) { console.log("A negative bet? Did you hit your head or...?\n"); return balance; }
    
    let betChoice = 0;
    let input = prompt("\n0: Lower than 3\n1: Higher than 2\nHurry up and pick a number: ");
    switch (input) { //Exception handling for betChoice
            case "0": betChoice = 0; break;
            case "1": betChoice = 1; break;
            default: console.log("You can only enter 0 or 1, fufu~ Try again!\n"); return balance;
    }

    //Game 2's Logic
    console.log("Your dice rolled: " + dice1 + " and " + dice2 + ". Their difference is " + diff);
    if ((betChoice == 0 && diff < 3) || (betChoice == 1 && diff > 2)) {
        balance += betAmount;
        console.log("I can't believe you won... ugh... good job!\n\n");
    }
    else {
        balance -= betAmount;
        console.log("Wueheheh, you lost again!\n\n");
    }
    return balance;    
}

function mainGameLoop(balance) {
    while (balance > 0) {
        console.log("Welcome to the Furina Betting Games. Your current balance is: " + balance + " Furidollars.");
        console.log("\n0: Double or Nothing Coin flip (You're heads).");
        let gameChoice = prompt("\n1: Dice Difference game with adjustable betting. Pick a game: ");
        switch (gameChoice) {
                case "0": balance = handleGameCoinflip(balance); break;
                case "1": balance = handleGameDice(balance); break;
                default: console.log("That isn't an available game, c\'mon!\n"); continue;
        }
    }
}

mainGameLoop(500);
console.log("Thank you for playing! I will now invest this money into Fontinalia Mousses~");