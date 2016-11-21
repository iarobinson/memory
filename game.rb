require_relative "card.rb"
require_relative "board.rb"
require "byebug"

class Game
  attr_reader :board

  def initialize(board_width = 4, board_height = 4)
    @board = Board.new(board_width, board_height)
  end

  def play_game
    until game_over?
      system "clear"
      @board.render

      move1 = process_move
      move2 = process_move

      sleep(2)

      card1 = get_object(move1)
      card2 = get_object(move2)
      hide_cards(card1,card2) unless found_match?(card1, card2)
      system "clear"

    end

    p "Huzzah! You Win!"
  end

  def process_move
    move = nil
    until valid_move?(move)
      move = request_move
    end
    get_object(move).reveal
    system "clear"
    @board.render
    move
  end

  def get_object(move)
    @board[move[0]][move[1]]
  end

  def found_match?(card1, card2)
    card1 == card2
  end

  def hide_cards(card1, card2)
    card1.hide
    card2.hide
  end

  def game_over?
    @board.flatten.all?(&:is_up)
  end

  def request_move
    p "Please guess a location for this card. Example 2,1"
    gets.chomp.split(",").map!(&:to_i)
  end

  def valid_move?(move)
    move.class == Array && in_bounds?(move) && card_still_down?(move)
  end

  def in_bounds?(move)
    bool = move[0].between?(0, @board.board_height)
    bool && move[1].between?(0, @board.board_width)
  end

  def card_still_down?(move)
    card = board[move[0]][move[1]]
    !card.is_up
  end

end


g = Game.new(4, 4)
g.play_game
