class Grid
  attr_reader :pixels

  def initialize(pixels)
    @pixels = map_pixels(pixels)
  end

  def map_pixels(pixels)
    pixels.inject({}) do |hash, pixel|
      hash.merge({ [pixel.row, pixel.column] => pixel })
    end
  end

  def pixel_at(row, column)
    pixels[[row, column]]
  end
end
