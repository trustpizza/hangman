require 'pry-byebug'
class Game
  attr_accessor :word, :word_to_array, :rounds_left, :progress, :win, :lose, :alphabet

  def initialize
    @word = select_word
    @word_to_array = @word.split('')
    @blank_word = blankify(@word)
    @guess = ''
    @game_over = false
    @win = check_win(@word, @blank_word, @game_over)
    @rounds_left = 10
    @progress = de_blankify(@blank_word, @word_to_array, @guess)
    @alphabet = ('a'..'z').to_a
  end

  def select_word
    dictionary = []
  
    contents = File.readlines('dictionary.txt')
    contents.each do |word|
      unless word.length < 5 || word.length > 12
        dictionary.push(word)
      end
    end
  
    dictionary = dictionary.map { |word| word.gsub("\n", "") }
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

  def play(word, word_to_array, blank_word, rounds_left, progress, win, lose)
    until @win == true || @lose == true
      puts "Letters Remaining:"
      puts @alphabet.join(' ')

      @guess = get_guess()
      @alphabet.delete(@guess)

      @progress = de_blankify(blank_word, word_to_array, @guess)
      puts @progress

      @rounds_left -= 1
      puts "You have #{@rounds_left} guesses left"

      @win = check_win(@blank_word, @word, @game_over)

      @lose = check_lose(@rounds_left, @win)
    end
    puts "The word was #{@word}"
  end
end

new_game = Game.new
new_game.play(@word, @word_to_array, @blank_word, @rounds_left, @progress, @win, @lose)



