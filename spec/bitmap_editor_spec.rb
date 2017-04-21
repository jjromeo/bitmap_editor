require 'bitmap_editor'
RSpec.describe BitmapEditor do
  context '#create_image' do
    let(:grid) { double :grid }
    let(:grid_class) { double :grid_class, with_dimensions: grid }
    let(:bme) { BitmapEditor.new(grid_class) }

    it 'will create a grid with the dimensions specified' do
      expect(grid_class).to receive(:with_dimensions).with(5, 8)
      bme.create_image(5, 8)
    end

    it 'will set its grid to the grid created' do
      expect(bme.grid).to eq nil
      bme.create_image(5, 8)
      expect(bme.grid).to eq grid
    end
  end
end
