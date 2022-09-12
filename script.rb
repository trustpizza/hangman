require 'pry-byebug'

word = 'grace' # Eventually will need to generate a random word
word_to_array = word.split('')

def blankify(word)
    out = ""
    word.length.times { out += "_"}
    out
end

def get_guess()
    puts 'Choose a letter'
    out = gets.chomp.downcase.split('')[0]
end 

blank_word = blankify(word)

def de_blankify(blank_word, word_to_array, guess)
    word_to_array.each_with_index do |letter, index|
        if letter == guess
            blank_word[index] = guess
        end
    end
    blank_word
end

game_over = false

def play(blank_word, word_to_array, game_over)
    until game_over == true
        guess = get_guess()
        progress = de_blankify(blank_word, word_to_array, guess)
        puts progress
        check_win()
    end
end
        
play(blank_word, word_to_array, game_over)