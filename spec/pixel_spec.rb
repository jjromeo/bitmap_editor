require 'pixel'
RSpec.describe Pixel do
  it 'is initialized with coordinates' do
    pixel = Pixel.new(1, 5)
    expect(pixel.row).to eq 1
    expect(pixel.column).to eq 5
  end

  it 'starts off blank' do
    pixel = Pixel.new(0, 0)
    expect(pixel.colour).to eq 'O'
  end
end
