class Move
  VALUES = %w(rock paper scissors)

  def initialize(value)
    @value = value
  end

  def scissors?
    @value == 'scissors'
  end

  def rock?
    @value == 'rock'
  end

  def paper?
    @value == 'paper'
  end

  def >(other_move)
    (rock? && other_move.scissors?) ||
      (paper? && other_move.rock?) ||
      (scissors? && other_move.paper?)
  end

  def <(other_move)
    other_move > self
  end

  def to_s
    @value
  end
end

class Player
  attr_accessor :move, :name
  attr_reader :score

  def initialize
    set_name
    @score = 0
  end

  def increase_score
    @score += 1
  end

  def reset_score
    @score = 0
  end
end

class Human < Player
  def set_name
    n = nil
    loop do
      puts "What's your name?"
      n = gets.chomp
      break unless n.empty?
      puts "Sorry, must enter a value."
    end
    self.name = n
  end

  def choose
    choice = nil
    loop do
      puts "Please choose rock, paper, or scissors:"
      choice = gets.chomp
      break if Move::VALUES.include?(choice)
      puts "Sorry, invalid choice"
    end
    self.move = Move.new(choice)
  end
end

class Computer < Player
  def set_name
    self.name = ['R2D2', 'Hal', 'Chappie', 'Sonny', 'Number 5'].sample
  end

  def choose
    self.move = Move.new(Move::VALUES.sample)
  end
end

# Game Orchestration Engine
class RPSGame
  attr_accessor :human, :computer

  def initialize
    @human = Human.new
    @computer = Computer.new
  end

  def display_welcome_message
    puts "Welcome to Rock, Paper, Scissors!"
  end

  def display_goodbye_message
    puts "Thanks for playing Rock, Paper, Scissors! Good bye!"
  end

  def display_moves
    system 'clear'
    puts "#{human.name} chose #{human.move}!"
    puts "#{computer.name} chose #{computer.move}!"
  end

  def calculate_winner
    if human.move > computer.move
      human
    elsif human.move < computer.move
      computer
    end
  end

  def display_winner(winner)
    if winner
      puts "#{winner.name} won!"
    else
      puts "It's a tie!"
    end
  end

  def display_score
    puts "#{human.name}: #{human.score}  #{computer.name}: #{computer.score}"
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp
      break if ['y', 'n'].include?(answer.downcase)
      puts "Sorry, must be y or n"
    end

    answer == 'y'
  end

  def first_to_five_winner
    if human.score == 5
      human
    elsif computer.score == 5
      computer
    end
  end

  def first_to_five
    until first_to_five_winner
      human.choose
      computer.choose
      display_moves
      winner = calculate_winner
      display_winner(winner)
      winner&.increase_score
      display_score
    end

    puts "#{first_to_five_winner.name} won the first to five!!"
  end

  def play
    display_welcome_message

    loop do
      puts "First to five! Let's start!"
      first_to_five
      break unless play_again?
      human.reset_score
      computer.reset_score
      system 'clear'
    end
    display_goodbye_message
  end
end

RPSGame.new.play
