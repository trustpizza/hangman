word = 'grace' # Eventually will need to generate a random word
word_to_array = word.split('')

def blankify(word)
    out = ""
    word.length.times { out += "_"}
    out
end

def guess
    puts 'Choose a letter'
    guess = gets.chomp.downcase.split('')[0]
end 

blank_word = blankify(word)
puts blank_word

def de_blankify(blank_word, word_to_array, guess)
    word_to_array.each_with_index do |letter, index|
        if letter == guess
            blank_word[index] = guess
        end
    end
end

de_blankify(blank_word, word_to_array, guess)

game_over = false

def play(blank_word, word_to_array, game_over)
    until game_over == true
        guess = guess()
        de_blankify(blank_word, word_to_array, guess)
    end
end
        
play(blank_word, word_to_array, game_over)