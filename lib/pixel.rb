class Pixel
  attr_reader :row, :column, :colour

  def initialize(row, column)
    @row = row
    @column = column
    @colour = 'O'
  end
end
