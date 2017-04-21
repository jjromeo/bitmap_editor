require 'bitmap_editor'
RSpec.describe BitmapEditor do
  let(:grid) { double :grid }
  let(:grid_class) { double :grid_class, with_dimensions: grid }
  let(:bme) { BitmapEditor.new(grid_class) }

  context '#create_image' do
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

  context '#reset' do
    before { bme.create_image(1,1) }
    it 'will reset its grid' do
      expect(grid).to receive(:reset)
      bme.reset
    end
  end

  context '#paint_pixel' do
    before { bme.create_image(1,1) }
    it 'will call its grid to color a pixel at the specified location' do
      pixel = double :pixel
      expect(pixel).to receive(:paint).with('A')
      allow(grid).to receive(:pixel_at).with(1, 1).and_return(pixel)
      bme.paint_pixel(row: 1, column: 1, colour: 'A')
    end
  end

  context '#paint_vertical_line' do
    before { bme.create_image(3, 3) }
    it 'will paint all pixels with the same column' do
      pixel1 = double :pixel
      pixel2 = double :pixel
      pixel3 = double :pixel
      diff_column_pixel = double :pixel

      allow(grid).to receive(:pixel_at).with(1, 1).and_return(pixel1)
      allow(grid).to receive(:pixel_at).with(2, 1).and_return(pixel2)
      allow(grid).to receive(:pixel_at).with(3, 1).and_return(pixel3)
      allow(grid).to receive(:pixel_at).with(1, 2).and_return(diff_column_pixel)

      expect(pixel1).to receive(:paint).with('W')
      expect(pixel2).to receive(:paint).with('W')
      expect(pixel3).to receive(:paint).with('W')
      expect(diff_column_pixel).not_to receive(:paint)

      bme.paint_vertical_line(column: 1, from_row: 1, to_row: 3, colour: 'W')
    end
  end
end
