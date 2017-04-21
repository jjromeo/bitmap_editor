class Pixel
  attr_reader :row, :column
  attr_accessor :colour

  def initialize(column, row)
    @column = column
    @row = row
    @colour = 'O'
  end

  def paint(colour)
    self.colour = colour
  end
end
