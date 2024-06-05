--To run locally, cd to the project folder and do 'cabal run'
{-# LANGUAGE ScopedTypeVariables #-}
import System.Random --'cabal install random'
import Control.Monad
import Text.Read 

handleGameCoinflip :: Int -> IO Int
handleGameCoinflip balance = do
    b <- randomIO --Generate a True or False
    let coin = if b then "Heads" else "Tails"
    let resultText = 
          if b 
          then "You won! Your balance is doubled! You may now rejoice in this~\n"
          else "You lost. What's done is done~.\n"
    let balanceModifier = if b then 2 else 0
        
    putStrLn ("Flipping your coin... It landed on " ++ coin ++ "!\n" ++ resultText)
    return (balance * balanceModifier)
    
handleGameDice :: Int -> IO Int
handleGameDice balance = do
    putStrLn "How much do you want to bet: "
    betAmount <- getLine
    --Exception handling
    case readMaybe betAmount of
        Just (i :: Int) -> return i
        Nothing -> do
            putStrLn "Stop messing with me!\n"
            handleGameDice balance
            
    let betAmount' = read betAmount::Int
    
    if ((betAmount' < 0) || (betAmount' > balance))
    then do
        putStrLn "Stop messing with me!\n"
        handleGameDice balance
    else do
        putStrLn "0: Lower than 3\n1: Higher than 2\nHurry up and pick a number: "
        betChoice <- getLine
                
        --Generates a random integer between 1 and 6 for both dice, then get their difference
        [dice1,dice2] <- replicateM 2 (randomRIO (1,6)) :: IO [Int] 
        let diff = abs (dice1 - dice2)

        putStrLn ("Your dice rolled: " ++ show dice1 ++ " and " ++ show dice2 ++ ". Their difference is " ++ show diff ++ "\n")
        if ((betChoice == "0" && diff < 3) || (betChoice /= "0" && diff > 2))
        then putStrLn "I can't believe you won... ugh... good job!\n\n"
        else putStrLn "Wueheheh, you lost again!\n\n"
        
        let balanceModifier' = if ((betChoice == "0" && diff < 3) || (betChoice /= "0" && diff > 2))
            then betAmount'
            else -betAmount'
            
        return (balance + balanceModifier')

mainGameLoop :: Int -> IO ()
mainGameLoop balance = loop balance
 where
  loop balance = do
    putStrLn ("Welcome to the Furina Betting Games. Your current balance is " ++ show balance ++ " Furidollars.")
    putStrLn "0: Double or Nothing Coin flip (You're heads)."
    putStrLn "1: Dice Difference game with adjustable betting. Pick a game: "
    gameChoice <- getLine

    -- The arrow pointing towards newBalance is for calling function with parameter(s)
    -- Otherwise, you would use = for if-then-else and case for functional syntax
    newBalance <- case gameChoice of
      "0" -> handleGameCoinflip balance
      "1" -> handleGameDice balance
      _ -> do
        putStrLn "That isn't an available game, c\'mon!"
        pure balance

    if newBalance > 0
      then loop newBalance
      else putStrLn "Thank you for playing! I will now invest this money into Fontinalia Mousses~"

main :: IO ()
main = do
    mainGameLoop 500