Pseudo Coding

Problem:  We want a computer to query a dictionary file to get a word between 5 and 12 characters long
Each letter should be displayed as a "_ " to indicate a blank spot
The user has a maximum of 6 guesses to get each word
Each guess the user is asked to guess a letter in the alphabet
If the letter matches any of the letters in the hidden word, change the " _ " to the letter shown 

users should be able to save their progress

users should see how many tries they have left

when a game loads in, the user should be have the option to start a new game (overwright the data of the save file) or continue the round they're on

1st Step: Guessing functionality 

word = "grace"

word_to_array = word.split('')

guesses_remaining = 6

progress = a string of " _ " repeated word.length times

alphabet = a-z array

guess = ""

def update_progress(guess)
  search each word_to_array entry and if it matches with (when lowercase) with guess, update progress[word_to_array matched   entry] to show as appropriate
end

def remove_from_alphabet(guess)
  remove guess from alphabet
end

def guess
  guess = ask player "Guess a letter?" (lowercase)
  remove guess from alphabet
  guesses_remaining -= 1
  return guess
end

def player_won?(progress, word)
  does progress == word?
  if yes => Player has Won!
end

def play(guesses_remaining, progress, word)
  until guesses_remaining == 0 OR player_won?
    print_alphabet
    guess = guess()
    remove_from_alphabet
    update_progress(guess())
    player_won?(progress, word)
  end
end
    
    
