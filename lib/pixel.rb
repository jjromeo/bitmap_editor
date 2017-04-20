class Pixel
  attr_reader :row, :column
  attr_accessor :colour

  def initialize(row, column)
    @row = row
    @column = column
    @colour = 'O'
  end

  def paint(colour)
    self.colour = colour
  end
end
