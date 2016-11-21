class Card
  attr_reader :face_value, :is_up

  def initialize(face_value)
    @face_value = face_value
    @is_up = false
  end

  def hide
    @is_up = false
  end

  def reveal
    @is_up = true
  end

  def ==(other_card)
    self.face_value == other_card.face_value
  end
end
