-- List of words for the game
local words = {"hangman", "computer", "programming", "lua", "gaming", "console", "challenge"}

-- Function to choose a random word from the list
local function chooseWord()
    math.randomseed(os.time())
    return words[math.random(1, #words)]
end

-- Function to display the current state of the word
local function displayWord(word, guessedLetters)
    local display = ""
    for i = 1, #word do
        local letter = word:sub(i, i)
        if guessedLetters[letter] then
            display = display .. letter .. " "
        else
            display = display .. "_ "
        end
    end
    return display
end

-- Function to check if the player has won
local function checkWin(word, guessedLetters)
    for i = 1, #word do
        local letter = word:sub(i, i)
        if not guessedLetters[letter] then
            return false
        end
    end
    return true
end

-- Function to display the main menu
local function displayMenu()
    print("=================")
    print("    HANGMAN")
    print("=================")
    print("[1] Start Game")
    print("[2] Credits")
    print("[3] Exit")
end

-- Function to run the game
local function runGame()
    local wordToGuess
    local guessedLetters
    local attempts

    displayMenu()
    local choice = io.read("*n")

    if choice == 1 then
        wordToGuess = chooseWord()
        guessedLetters = {}
        attempts = 6

        print("Welcome to Hangman!")
        print("Try to guess the word.")
        print(displayWord(wordToGuess, guessedLetters))

        while attempts > 0 do
            print("\nAttempts left: " .. attempts)
            io.write("Enter a letter: ")
            local guess = io.read():sub(1, 1):lower()

            if guessedLetters[guess] then
                print("You've already guessed '" .. guess .. "'. Try a different letter.")
            else
                guessedLetters[guess] = true

                if wordToGuess:find(guess, 1, true) then
                    print("Nice guess! '" .. guess .. "' is in the word.")
                    print(displayWord(wordToGuess, guessedLetters))
                    if checkWin(wordToGuess, guessedLetters) then
                        print("\nCongratulations! You've successfully guessed the word: '" .. wordToGuess .. "'!")
                        break
                    end
                else
                    print("Oops! '" .. guess .. "' is not in the word.")
                    attempts = attempts - 1
                    if attempts == 0 then
                        print("Sorry, you're out of attempts. The word was: '" .. wordToGuess .. "'.")
                        break
                    else
                        print(displayWord(wordToGuess, guessedLetters))
                    end
                end
            end
        end
    elseif choice == 2 then
        print("Hangman created by [Mitja Kurath]")
    elseif choice == 3 then
        print("Goodbye!")
    else
        print("Invalid choice. Please select a valid option.")
    end
end

-- Run the game
runGame()
