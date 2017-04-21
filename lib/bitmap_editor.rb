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
    @grid = grid_class.with_dimensions(rows, columns)
  end

  def clear
    grid.reset
  end
end
