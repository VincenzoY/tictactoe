class Game
  def initialize
    @spots = {"1" => 1, "2" => 2, "3" => 3, "4" => 4, "5" => 5, "6" => 6, "7" => 7, "8" => 8, "9" => 9}
    @allowed = [1,2,3,4,5,6,7,8,9]
    @game_over = false
    #checks which player the game is on for player setup
    @player_one_turn = true
    #false means y wins, true means x wins
    @winner = false
  end

  def play
    puts "Welcome to the Game!"
    player_setup("X")
    player_setup("Y") 
    self.play_round
    self.end_screen
    self.play_again
  end

  def play_round
    puts
    self.board
    while @game_over == false
      choose_spot("X")
      puts
      self.board
      self.check_game_over("X")
      @game_over ? break:
      choose_spot("Y")
      puts
      self.board
      self.check_game_over("Y")
    end
  end

  def choose_spot(piece)
  puts
    if @player_one_turn
      puts "#{@player_one}, choose a number to place your piece there."
      choice = gets.chomp
      if @allowed.include?(choice.to_i) && @allowed.include?(@spots[choice])
        @spots[choice] = piece
      else 
        puts "That's not a valid spot."
        choose_spot("X")
      end
      @player_one_turn = !@player_one_turn
    else 
      puts "#{@player_two}, choose a number to place your piece there."
      choice = gets.chomp
      if @allowed.include?(choice.to_i) && @allowed.include?(@spots[choice])
        @spots[choice] = piece
      else 
        puts "That's not a valid spot."
        choose_spot("Y")
      end
      @player_one_turn = !@player_one_turn
    end
  end

  def board
    puts "#{@spots["1"]} | #{@spots["2"]} | #{@spots["3"]}"
    puts "---------"
    puts "#{@spots["4"]} | #{@spots["5"]} | #{@spots["6"]}"
    puts "---------"
    puts "#{@spots["7"]} | #{@spots["8"]} | #{@spots["9"]}"
  end

  def player_setup(piece)
    puts
    if @player_one_turn
      puts "What's your name Player One?"
      @player_one = gets.chomp
      puts "Welcome #{@player_one}! You are #{piece}"
      @player_one_turn = !@player_one_turn
    else
      puts "What's your name Player Two?"
      @player_two = gets.chomp
      puts "Welcome #{@player_two}! You are #{piece}"
      @player_one_turn = !@player_one_turn
    end
  end

  def check_game_over(piece)
    #vertical
    [1,2,3].each { |a| 
      if(@spots["#{a}"] == piece && @spots["#{a+3}"] == piece && @spots["#{a+6}"] == piece) 
        @game_over = true
        @winner = piece
        break
      end
    }
    #horizontal
    [1,4,7].each { |a| 
      if(@spots["#{a}"] == piece && @spots["#{a+1}"] == piece && @spots["#{a+2}"] == piece) 
        @game_over = true
        @winner = piece
        break
      end
    }
    #diaganols
    if((@spots["1"] == piece && @spots["5"] == piece && @spots["9"] == piece) || (@spots["3"] == piece && @spots["5"] == piece && @spots["7"] == piece))
      @game_over = true
      @winner = piece
    end

    #all squares filled
    if @spots.values.all? { |a| a == "X" || a == "Y" }
      @game_over = true
      @winner = "tie"
    end
  end 

  def end_screen
    puts
    if @winner == "X"
      puts "Congrats #{@player_one}! You win!"
    elsif @winner == "Y"
      puts "Congrats #{@player_two}! You win!"
    else
      puts "Nice try! It's a tie."
    end
  end

  def play_again
    puts
    puts "Would you like to play again? (Y/N)"
    again = gets.chomp
    if again == "Y" 
      puts
      x = Game.new
      x.play
    elsif again == "N" 
      puts
      puts "Thanks for playing!"
    else
      "That's not a valid answer."
      self.play_again
    end
  end

end

x = Game.new
x.play
