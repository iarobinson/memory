require_relative "card.rb"

class Board
  attr_reader :board_width, :board_height
  def initialize(board_width, board_height)
    @board_width = board_width
    @board_height = board_height
    @board = create_board
    assign_card_to_spot
  end

  def create_board
    Array.new(@board_height) { Array.new(@board_width) }
  end

  def assign_card_to_spot
    deck = create_deck
    @board.each do |row|
      @board_width.times do |i|
        row[i] = Card.new(deck.pop)
      end
    end
    @board
  end

  def flatten
    @board.flatten
  end

  def render

    @board.each do |row|
      row_string = 'Row # | '

      row.each do |card_object|
        if card_object.is_up
          row_string += "#{card_object.face_value} "
        else
          row_string += "X "
        end
      end

      p row_string
    end
  end

  def create_deck
    total_cards = @board_height * @board_width
    card_types = total_cards / 2
    deck = []
    1.upto(card_types) do |x|
      deck << x
      deck << x
    end
    deck.shuffle
  end

  def won?
    # true if all cards face up
  end

  def reveal(guessed_pos)
    first = guessed_pos[0]
    second = guessed_pos[1]
    card_object = self[first][second]
    p "#{card_object.to_s} is the card's face value"
  end

  def [](pos)
    @board[pos]
  end

end
# [1,2]
# this_board = Board.new(2, 4)
# this_board.assign_card_to_spot
# this_board.render
# this_board.reveal([0,0])
