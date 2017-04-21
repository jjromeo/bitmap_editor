class Grid
  attr_reader :pixel_map, :pixels

  def self.with_dimensions(columns:, rows:, pixel_class: Pixel)
    pixels = []
    rows.times do |row|
      columns.times do |column|
        pixels << pixel_class.new(column + 1, row + 1)
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
      hash.merge({ [pixel.column, pixel.row] => pixel })
    end
  end

  def pixel_at(column, row)
    pixel_map[[column, row]]
  end

  def clear
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
