require 'pry-byebug'

word = 'grace'

guesses_remaining = 6

alphabet = ('a'..'z').to_a

def hide_word(word)
    out = ""
    word.length.times { out += "_ "}
    out
end

def guess(guesses_remaining)  
    puts "Guess a letter!"
    guesses_remaining -= 1
    guess = gets.chomp.downcase.split('')[0]
end

def remove_guess_from_alphabet(alphabet, guess)
    alphabet.delete(guess)
    alphabet = alphabet.join(' ')
end

def check_guess(guess, word)
    location_correct = -1
    word.split(' ').each do |letter|
        if guess == letter
            location_correct = word.find_index(letter)
        end
    end
end

def change_hidden_word(hidden_word, guess)
    hidden_word
end

def game_over?(guesses_remaining, players_guess)
    if players_guess == word
        puts "You Win"
    elsif guesses_remaining == 0
        puts "You Lose"
    end
end

def play (word, guesses_remaining, players_guess, alphabet)
    hidden_word = hide_word(word)
    puts hidden_word

    puts alphabet

    guess = guess(guesses_remaining)
    
    check_guess = check_guess(guess, word)
    if check_guess >= 0
        show_letter
        change_alphabet
    end

end


