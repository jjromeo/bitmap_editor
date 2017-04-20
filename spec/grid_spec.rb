require 'grid'
RSpec.describe Grid do
    let(:pixel) { double :pixel, row: 1, column: 1 }
    let(:pixel2) { double :pixel, row: 2, column: 1 }
    let(:grid) { Grid.new([pixel, pixel2]) }

  it 'can be initialized with a set of pixels ' do
    expect(grid.pixels).to eq({ [1, 1] => pixel, [2, 1] => pixel2 })
  end

  it 'can access a pixel with a set of coordinates' do
    expect(grid.pixel_at(1,1)).to eq pixel
  end
end
