require 'bitmap_editor'
RSpec.describe BitmapEditor do
  let(:grid) { double :grid }
  let(:grid_class) { double :grid_class, with_dimensions: grid }
  let(:bme) { BitmapEditor.new(grid_class) }

  context '#create_image' do
    it 'will create a grid with the dimensions specified' do
      expect(grid_class).to receive(:with_dimensions).with(rows: 5, columns: 8)
      bme.create_image(5, 8)
    end

    it 'will set its grid to the grid created' do
      expect(bme.grid).to eq nil
      bme.create_image(5, 8)
      expect(bme.grid).to eq grid
    end
  end

  context '#clear' do
    before { bme.create_image(1,1) }
    it 'will clear its grid' do
      expect(grid).to receive(:clear)
      bme.clear
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

  context 'painting multiple pixels' do
    let(:pixel1) { double :pixel, paint: nil }
    let(:pixel2) { double :pixel, paint: nil }
    let(:pixel3) { double :pixel, paint: nil }
    let(:diff_column_pixel) { double :pixel }
    let(:diff_row_pixel) { double :pixel }
    let(:out_of_range_pixel) { double :pixel }

    before { bme.create_image(4, 4) }

    context '#paint_vertical_line' do
      before do
        allow(grid).to receive(:pixel_at).with(1, 1).and_return(pixel1)
        allow(grid).to receive(:pixel_at).with(2, 1).and_return(pixel2)
        allow(grid).to receive(:pixel_at).with(3, 1).and_return(pixel3)
        allow(grid).to receive(:pixel_at).with(4, 1).and_return(out_of_range_pixel)
        allow(grid).to receive(:pixel_at).with(1, 2).and_return(diff_column_pixel)
      end

      after do
        bme.paint_vertical_line(column: 1, from_row: 1, to_row: 3, colour: 'W')
      end

      it 'will paint all pixels within the same column for the range specified' do
        expect(pixel1).to receive(:paint).with('W')
        expect(pixel2).to receive(:paint).with('W')
        expect(pixel3).to receive(:paint).with('W')
      end

      it 'will not paint a pixel which is in the same col but out of range' do
        expect(out_of_range_pixel).not_to receive(:paint)
      end

      it 'will not paint a pixel in a diff column' do
        expect(diff_column_pixel).not_to receive(:paint)
      end
    end

    context '#paint_horizontal_line' do
      before do
        allow(grid).to receive(:pixel_at).with(1, 1).and_return(pixel1)
        allow(grid).to receive(:pixel_at).with(1, 2).and_return(pixel2)
        allow(grid).to receive(:pixel_at).with(1, 3).and_return(pixel3)
        allow(grid).to receive(:pixel_at).with(1, 4).and_return(out_of_range_pixel)
        allow(grid).to receive(:pixel_at).with(2, 1).and_return(diff_row_pixel)
      end

      after do
        bme.paint_horizontal_line(row: 1, from_column: 1, to_column: 3, colour: 'Z')
      end

      it 'will paint all pixels within the same row for the range specified' do
        expect(pixel1).to receive(:paint).with('Z')
        expect(pixel2).to receive(:paint).with('Z')
        expect(pixel3).to receive(:paint).with('Z')
      end

      it 'will not paint a pixel which is in the same row but out range' do
        expect(out_of_range_pixel).not_to receive(:paint)
      end

      it 'will not paint a pixel in a different row' do
        expect(diff_row_pixel).not_to receive(:paint)
      end
    end
  end
end
