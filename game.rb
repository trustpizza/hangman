require 'pry-byebug'
require 'json'

class Game
  attr_accessor :word, :blank_word, :rounds_left, :progress, :alphabet

  def initialize
    load_game
  end
  
  def load_game
    puts "Would you like to load your saved game? [Y/N]"
    answer = gets.chomp.downcase
  
    if answer == "y"
      file = File.read("./save_file.json")
      json_to_hash = JSON.parse(file)

      @word = json_to_hash["word"]
      @word_to_array = @word.split("")
      @blank_word = json_to_hash["blank_word"]
      @progress = json_to_hash["progress"]
      @rounds_left = json_to_hash["rounds_left"]
      @alphabet = json_to_hash["alphabet"]
      
      puts @progress
      play(@word, @word_to_array, @blank_word, @rounds_left, @progress, @win, @lose)
    else
      @word = select_word
      @word_to_array = @word.split("")
      @blank_word = blankify(@word)
      @guess = ""
      @game_over = false 
      @win = check_win(@word, @blank_word, @game_over)
      @rounds_left = 10
      @progress = de_blankify(@blank_word, @word_to_array, @guess)
      @alphabet = ('a'..'z').to_a

      play(@word, @word_to_array, @blank_word, @rounds_left, @progress, @win, @lose)
    end
  end

  def select_word 
    dictionary = []
  
    contents = File.readlines('dictionary.txt')
    contents.each do |word|
      unless word.length < 5 || word.length > 12
        dictionary.push(word)
      end
    end
  
    dictionary = dictionary.map { |word| word.gsub("\n", "") } # Otherwise values will have the \n (newline) tag and will display with an extra "_" when blankify-ed
    dictionary.sample
  end

  def blankify(word)
    out = ''
    @word.length.times { out += '_' }
    out
  end

  def de_blankify(blank_word, word_to_array, guess)
    @word_to_array.each_with_index do |letter, index|
      @blank_word[index] = @guess if letter == @guess
    end
    @blank_word
  end

  def get_guess
    puts 'Choose a letter'
    out = gets.chomp.downcase.split('')[0]
    out.nil? ? get_guess : out # Stop nil values from being passed as arguments further down the program
  end

  def is_correct_guess(word, guess)
    unless word.include?(guess) # We don't want to decrement game counter unless the guess is wrong
      @rounds_left -= 1
    end
  end

  def check_win(word, blank_word, game_over)
    if @blank_word == @word
      puts 'You Win!'
      @game_over = true
    end
    @game_over
  end

  def check_lose(rounds_left, win)
    out = false
    if @rounds_left.zero? && @win == false
      puts 'You Lose!'
      out = true
    end
    out
  end

  def save_game(word, blank_word, progress, rounds_left, alphabet)
    save_file = Hash.new
    save_file[:word] = word
    save_file[:blank_word] = blank_word
    save_file[:progress] = progress
    save_file[:rounds_left] = rounds_left
    save_file[:alphabet] = alphabet

    file_name = "save_file.json"
    File.open(file_name, "w") do |item|
      item.write(save_file.to_json)
    end
  end

  def play(word, word_to_array, blank_word, rounds_left, progress, win, lose)
    until @win == true || @lose == true
      puts "Letters Remaining:"
      puts @alphabet.join(' ')

      @guess = get_guess()
      @alphabet.delete(@guess)

      @progress = de_blankify(blank_word, word_to_array, @guess)
      puts @progress
      
      is_correct_guess(@word, @guess) 
      
      puts "You have #{@rounds_left} wrong guesses left"

      @win = check_win(@blank_word, @word, @game_over)

      @lose = check_lose(@rounds_left, @win)
      
      save_game(@word, @blank_word, @progress, @rounds_left, @alphabet)
    end
    puts "The word was #{@word.capitalize}"
  end
end

Game.new
