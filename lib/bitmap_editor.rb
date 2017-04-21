class BitmapEditor

  attr_reader :grid_class, :grid

  def run(file)
    return puts "please provide correct file" if file.nil? || !File.exists?(file)

    File.open(file).each do |line|
      line = line.chomp
      case line
      when 'S'
          puts "There is no image"
      else
          puts 'unrecognised command :('
      end
    end
  end

  def initialize(grid_class = Grid)
    @grid = nil
    @grid_class = grid_class
  end

  def create_image(rows, columns)
    @grid = grid_class.with_dimensions(rows: rows, columns: columns)
  end

  def clear
    grid.clear
  end

  def paint_pixel(row:, column:, colour:)
    grid.pixel_at(row, column).paint(colour)
  end

  def paint_vertical_line(column:, from_row:, to_row:, colour:)
    (from_row..to_row).each do |row|
      grid.pixel_at(row, column).paint(colour)
    end
  end

  def paint_horizontal_line(row:, from_column:, to_column:, colour:)
    (from_column..to_column).each do |column|
      grid.pixel_at(row, column).paint(colour)
    end
  end

  def display_image
    puts grid.display_image
  end
end
