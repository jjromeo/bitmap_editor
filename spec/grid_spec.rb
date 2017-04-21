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
end
