require 'pixel'
RSpec.describe Pixel do
  it 'is initialized with coordinates' do
    pixel = Pixel.new(1, 5)
    expect(pixel.row).to eq 1
    expect(pixel.column).to eq 5
  end
end
