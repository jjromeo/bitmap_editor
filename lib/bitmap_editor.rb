class BitmapEditor

  attr_reader :grid_class, :grid

  def run(file, reader = InstructionReader.new)
    return puts "please provide correct file" if file.nil? || !File.exists?(file)

    commands = File.open(file).map do |line|
      line = line.chomp
      reader.interpret(line)
    end
    commands.each { |command| public_send(*command) }
  end

  def initialize(grid_class = Grid)
    @grid = nil
    @grid_class = grid_class
  end

  def create_image(columns, rows)
    @grid = grid_class.with_dimensions(columns: columns, rows: rows)
  end

  def clear
    grid.clear
  end

  def paint_pixel(column, row, colour)
    grid.pixel_at(column, row).paint(colour)
  end

  def paint_vertical_line(column, from_row, to_row, colour)
    (from_row..to_row).each do |row|
      paint_pixel(column, row, colour)
    end
  end

  def paint_horizontal_line(row, from_column, to_column, colour)
    (from_column..to_column).each do |column|
      paint_pixel(column, row, colour)
    end
  end

  def display_image
    puts grid.display_image
  end
end
