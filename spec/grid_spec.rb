require 'grid'
RSpec.describe Grid do
  let(:pixel) { double :pixel, row: 1, column: 1 }
  let(:pixel2) { double :pixel, row: 1, column: 2 }
  let(:grid) { Grid.new([pixel, pixel2]) }

  it 'can be initialized with a set of pixels ' do
    expect(grid.pixels).to eq [pixel, pixel2]
  end

  it 'will have a map of coordinates to its pixels' do
    expect(grid.pixel_map).to eq({ [1, 1] => pixel, [1, 2] => pixel2 })
  end

  it 'can access a pixel with a set of coordinates' do
    expect(grid.pixel_at(1,1)).to eq pixel
  end

  it 'can reset all its pixels to default colour' do
    expect(pixel).to receive(:paint).with('O')
    expect(pixel2).to receive(:paint).with('O')
    grid.reset
  end

  context 'with_dimensions' do
    let(:rows) { 5 }
    let(:columns) { 5 }
    let(:generic_pixel) { double :pixel, row: 1, column: 1 }
    let(:pixel_class) { double :pixel_class, new: generic_pixel }

    it 'instantiates a grid' do
      grid = Grid.with_dimensions(rows: rows, columns: columns, pixel_class: pixel_class)
      expect(grid).to be_an_instance_of(Grid)
    end

    context 'instantiating pixels' do
      after do
        Grid.with_dimensions(rows: rows, columns: columns, pixel_class: pixel_class)
      end

      it 'instantiates the expected amount of pixels' do
        expect(pixel_class).to receive(:new).exactly(25).times

      end

      it 'instantiates pixels with the expected rows and columns' do
        rows.times do |row|
          columns.times do |column|
            expect(pixel_class).to receive(:new).with(row + 1, column + 1)
          end
        end
      end
    end
  end

  context 'display_image' do
    context 'with a 3 X 3 grid' do
      let(:pixel1) { double :pixel, row: 1, column: 1, colour: 'O' }
      let(:pixel2) { double :pixel, row: 1, column: 2, colour: 'O'}
      let(:pixel3) { double :pixel, row: 1, column: 3, colour: 'O'}
      let(:pixel4) { double :pixel, row: 2, column: 1, colour: 'O'}
      let(:pixel5) { double :pixel, row: 2, column: 2, colour: 'O'}
      let(:pixel6) { double :pixel, row: 2, column: 3, colour: 'O'}
      let(:pixel7) { double :pixel, row: 3, column: 1, colour: 'W'}
      let(:pixel8) { double :pixel, row: 3, column: 2, colour: 'O'}
      let(:pixel9) { double :pixel, row: 3, column: 3, colour: 'W'}
      let(:pixels) { [pixel1, pixel2, pixel3, pixel4, pixel5, pixel6, pixel7, pixel8, pixel9] }

      it 'will display a set of pixels with their colour as text' do
        grid = Grid.new(pixels)
        expect(grid.display_image).to eq "OOO\nOOO\nWOW"
      end

    end
  end

  context 'with a 4 x 4 grid' do
    let(:pixel1) { double :pixel, row: 1, column: 1, colour: 'M' }
    let(:pixel2) { double :pixel, row: 1, column: 2, colour: 'O'}
    let(:pixel3) { double :pixel, row: 1, column: 3, colour: 'O'}
    let(:pixel4) { double :pixel, row: 1, column: 4, colour: 'M'}
    let(:pixel5) { double :pixel, row: 2, column: 1, colour: 'A'}
    let(:pixel6) { double :pixel, row: 2, column: 2, colour: 'O'}
    let(:pixel7) { double :pixel, row: 2, column: 3, colour: 'O'}
    let(:pixel8) { double :pixel, row: 2, column: 4, colour: 'N'}
    let(:pixel9) { double :pixel, row: 3, column: 1, colour: 'O'}
    let(:pixel10) { double :pixel, row: 3, column: 2, colour: 'O'}
    let(:pixel11) { double :pixel, row: 3, column: 3, colour: 'O'}
    let(:pixel12) { double :pixel, row: 3, column: 4, colour: 'O'}
    let(:pixel13) { double :pixel, row: 4, column: 1, colour: 'O'}
    let(:pixel14) { double :pixel, row: 4, column: 2, colour: 'O'}
    let(:pixel15) { double :pixel, row: 4, column: 3, colour: 'O'}
    let(:pixel16) { double :pixel, row: 4, column: 4, colour: 'O'}
    let(:pixels) { [pixel1, pixel2, pixel3, pixel4, pixel5, pixel6, pixel7, pixel8, pixel9, pixel10, pixel11, pixel12, pixel13, pixel14, pixel15, pixel16] }

    it 'will display a set of pixels with their colour as text' do
      grid = Grid.new(pixels)
      expect(grid.display_image).to eq "MOOM\nAOON\nOOOO\nOOOO"
    end
  end
end
