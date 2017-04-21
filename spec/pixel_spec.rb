require 'pixel'
RSpec.describe Pixel do
  it 'is initialized with coordinates' do
    pixel = Pixel.new(5, 1)
    expect(pixel.row).to eq 1
    expect(pixel.column).to eq 5
  end

  it 'starts off blank' do
    pixel = Pixel.new(0, 0)
    expect(pixel.colour).to eq 'O'
  end

  it 'can change its colour' do
    pixel = Pixel.new(0, 0)
    expect { pixel.paint('C') }.to change { pixel.colour }.from('O').to('C')
  end
end
