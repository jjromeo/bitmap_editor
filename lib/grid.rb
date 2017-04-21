class Grid
  attr_reader :pixel_map, :pixels

  def self.with_dimensions(rows:, columns:, pixel_class: Pixel)
    pixels = []
    rows.times do |row|
      columns.times do |column|
        pixels << pixel_class.new(row + 1, column + 1)
      end
    end
    new(pixels)
  end

  def initialize(pixels)
    @pixels = pixels
    @pixel_map = map_pixels(pixels)
  end

  def map_pixels(pixels)
    pixels.inject({}) do |hash, pixel|
      hash.merge({ [pixel.row, pixel.column] => pixel })
    end
  end

  def pixel_at(row, column)
    pixel_map[[row, column]]
  end

  def reset
    pixels.each {|pixel| pixel.paint('O') }
  end

  def display_image
    last_pixel_row = nil
    pixels.inject("") do |string, pixel|
      if last_pixel_row.nil? || last_pixel_row == pixel.row
        string << pixel.colour
      else
        string << "\n#{pixel.colour}"
      end
      last_pixel_row = pixel.row
      string
    end
  end
end
