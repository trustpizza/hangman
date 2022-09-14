require 'pry-byebug'

words_sampled = File.read('google-10000-no-swears.txt')

class Game
  attr_accessor :word, :word_to_array, :rounds_left, :progress, :win, :lose, :alphabet

  def initialize(word)
    @word = word
    @word_to_array = @word.split('')
    @blank_word = blankify(@word)
    @guess = ''
    @game_over = false
    @win = check_win(@word, @blank_word, @game_over)
    @rounds_left = 10
    @progress = de_blankify(@blank_word, @word_to_array, @guess)
    @alphabet = ('a'..'z').to_a
  end

  def blankify(_word)
    out = ''
    @word.length.times { out += '_' }
    out
  end

  def de_blankify(_blank_word, _word_to_array, _guess)
    @word_to_array.each_with_index do |letter, index|
      @blank_word[index] = @guess if letter == @guess
    end
    @blank_word
  end

  def get_guess
    puts 'Choose a letter'
    out = gets.chomp.downcase.split('')[0]
  end

  def check_win(_word, _blank_word, _game_over)
    if @blank_word == @word
      puts 'You Win!'
      @game_over = true
    end
    @game_over
  end

  def check_lose(_rounds_left, _win, word)
    out = false
    if @rounds_left.zero? && @win == false
      puts 'You Lose!'
      out = true
    end
    puts "The word was #{@word}"
    out
  end

  def play(_word, word_to_array, blank_word, _rounds_left, _progress, _win, _lose, alphabet)
    until @win == true || @lose == true
      puts "Letters Remaining"
      puts @alphabet.join(' ')
      
      @guess = get_guess
      @alphabet.delete(@guess)
      
      @progress = de_blankify(blank_word, word_to_array, @guess)
      puts @progress

      @rounds_left -= 1
      puts "You have #{@rounds_left} guesses left"

      @win = check_win(@blank_word, @word, @game_over)

      @lose = check_lose(@rounds_left, @win, @word)
    end
  end
end

words_to_sample = []

allowed_words = File.readlines('google-10000-no-swears.txt')
allowed_words.each do |word|
  unless word.length < 5 || word.length > 12
    words_to_sample.push(word)
  end
end

new_game = Game.new(words_to_sample.sample)
new_game.play(@word, @word_to_array, @blank_word, @rounds_left, @progress, @win, @lose, @alphabet)
