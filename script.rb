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


def de_blankify(blank_word, word_to_array, guess)
    word_to_array.each_with_index do |letter, index|
        if letter == guess
            blank_word[index] = guess
        end
    end
    blank_word
end

def check_win(blank_word, word)
    game_over = false
    if blank_word == word
        puts "You Win!"
        game_over = true
    end
    game_over
end

def check_lose(rounds_left, win)
    out = false
    if rounds_left == 0 && win == false
        puts 'You Lose!'
        out = true
    end
    out
end

def play(word, word_to_array)
    rounds_left = 6

    blank_word = blankify(word)

    win = check_win(blank_word, word)
    lose = check_lose(rounds_left, win)

    until (win == true || lose == true)
        guess = get_guess()

        progress = de_blankify(blank_word, word_to_array, guess)
        puts progress

        win = check_win(blank_word, word)

        rounds_left -= 1
        lose = check_lose(rounds_left, win)
    end
end
        
play(word, word_to_array)