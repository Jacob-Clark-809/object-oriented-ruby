module Joinor
  def joinor(to_join, delimiter: ', ', final: 'or')
    case to_join.length
    when 0 then ''
    when 1 then to_join[0]
    when 2 then to_join.join(" #{final} ")
    else
      to_join[0..-2].join(delimiter) + delimiter +
        final + ' ' + to_join[-1].to_s
    end
  end
end

class Deck
  def initialize
    reset
  end

  def reset
    @cards = []
    Card::SUITS.each do |suit|
      Card::RANKS.each do |rank|
        @cards << Card.new(suit, rank)
      end
    end
  end

  def shuffle
    @cards.shuffle!
  end

  def draw_card
    @cards.pop
  end
end

class Card
  SUITS = [:hearts, :diamonds, :spades, :clubs]
  RANKS = [:two, :three, :four, :five, :six, :seven, :eight, :nine, :ten,
           :jack, :queen, :king, :ace]
  VALUES = [2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, 11]

  def initialize(suit, rank)
    @suit = suit
    @rank = rank
  end

  def to_s
    "#{@rank} of #{@suit}"
  end

  def value
    VALUES[RANKS.find_index(@rank)]
  end

  def ace?
    @rank == :ace
  end
end

class Participant
  attr_reader :name

  include Joinor

  def initialize
    @name = set_name
    @hand = []
  end

  def <<(card)
    @hand << card
  end

  def reveal_cards
    puts "#{@name} has: #{joinor(@hand, final: 'and')}. Total: #{total}"
  end

  def total
    initial_total = @hand.map(&:value).sum
    if initial_total > 21
      number_of_aces.times do
        initial_total -= 10
        break if initial_total < 22
      end
    end
    initial_total
  end

  def bust?
    total > 21
  end

  def empty_hand
    @hand = []
  end

  private

  def number_of_aces
    @hand.count(&:ace?)
  end
end

class Player < Participant
  def set_name
    system 'clear'
    puts "Please enter your name:"
    name = nil
    loop do
      name = gets.chomp
      break if !name.empty?
      puts "Please enter something!"
    end

    name
  end
end

class Dealer < Participant
  def set_name
    system 'clear'
    "The Dealer"
  end

  def reveal_one_card
    puts "#{@name} has: #{@hand[0]} and unknown card."
  end
end

class Game
  attr_accessor :deck, :player, :dealer

  def initialize
    @deck = Deck.new
    @player = Player.new
    @dealer = Dealer.new
  end

  def display_welcome_message
    clear
    puts "Welcome to Twenty One!"
    puts "Twist to add a card to your hand. Stick to end your turn."
    puts "Aces are worth 11 or 1."
    puts "Try to get as close to 21 as possible without going over!"
  end

  def display_goodbye_message
    puts "Thanks for playing Twenty One!"
  end

  def ready_to_play?
    puts "Ready to play? (y/n)"
    loop do
      answer = gets.chomp.downcase
      break if answer.start_with?('y')
      puts "Enter 'y' whenever you're ready!"
    end

    puts "Let's begin!"
    sleep(2)
  end

  def deal_cards
    deck.shuffle
    2.times do
      player << deck.draw_card
      dealer << deck.draw_card
    end
  end

  def display_cards_player_turn
    clear
    player.reveal_cards
    dealer.reveal_one_card
  end

  def display_cards_dealer_turn
    clear
    player.reveal_cards
    dealer.reveal_cards
  end

  def clear
    system 'clear'
  end

  def dealer_turn_intro
    puts "It's now #{dealer.name}'s turn!"
    sleep(2)
    display_cards_dealer_turn
  end

  def player_turn
    loop do
      player_move = stick_or_twist
      break if player_move == 's'
      player_twists
      display_cards_player_turn
      puts "#{player.name} twists!"
      break if player.bust?
    end

    puts "#{player.name} sticks!" unless player.bust?
  end

  def dealer_turn
    loop do
      sleep(2)
      break if dealer.total > 16
      dealer_twists
      display_cards_dealer_turn
      puts "#{dealer.name} twists!"
    end

    display_cards_dealer_turn
    puts "#{dealer.name} sticks!" unless dealer.bust?
  end

  def stick_or_twist
    answer = nil
    loop do
      puts "Would you like to stick or twist? (s/t)"
      answer = gets.chomp.downcase
      break if answer.start_with?('s') || answer.start_with?('t')
      puts "Sorry, that is not a valid input."
    end

    answer[0]
  end

  def player_twists
    player << deck.draw_card
  end

  def dealer_twists
    dealer << deck.draw_card
  end

  def scores
    "#{player.name} got #{player.total}. #{dealer.name} got #{dealer.total}."
  end

  def show_result
    someone_bust? ? display_bust : display_winner
  end

  def someone_bust?
    player.bust? || dealer.bust?
  end

  def display_bust
    if player.bust?
      puts "#{player.name} bust. #{dealer.name} wins!"
    elsif dealer.bust?
      puts "#{dealer.name} bust. #{player.name} wins!"
    end
  end

  def display_winner
    puts scores + " " + winner
  end

  def winner
    if player.total > dealer.total
      "#{player.name} wins!"
    elsif dealer.total > player.total
      "#{dealer.name} wins!"
    else
      "It's a draw!"
    end
  end

  def main_game
    loop do
      deal_cards
      display_cards_player_turn
      player_turn
      break if player.bust?

      dealer_turn_intro
      dealer_turn
      break
    end
    show_result
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp.downcase
      break if %w(y n).include? answer
      puts "Sorry, must be y or n"
    end

    answer == 'y'
  end

  def collect_cards
    deck.reset
    player.empty_hand
    dealer.empty_hand
  end

  def display_play_again_message
    puts "Okay, let's play again!"
    puts "Shuffling cards..."
    sleep(2)
  end

  def play
    display_welcome_message
    ready_to_play?
    loop do
      main_game

      break unless play_again?
      collect_cards
      display_play_again_message
    end

    display_goodbye_message
  end
end

Card.new(:hearts, :one)
Game.new.play
