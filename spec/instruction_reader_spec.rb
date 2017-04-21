require 'instruction_reader'
RSpec.describe InstructionReader do
  let(:reader) { InstructionReader.new }
  context 'I command' do
    it 'will interpret this to create an image' do
      expect(reader.interpret("I 5 6")).to eq [:create_image, 5, 6]
    end
  end

  context 'C command' do
    it 'will interpret this to clear an image' do
      expect(reader.interpret("C")).to eq [:clear]
    end

    it 'will ignore extra commands' do
      expect(reader.interpret("C 1 3")).to eq [:clear]
    end
  end

  context 'L command' do
    it 'will interpret this to colour a pixel' do
      expect(reader.interpret("L 1 3 A")).to eq [:paint_pixel, 1, 3, "A"]
    end

    it 'will ignore extra commands' do
      expect(reader.interpret("L 1 3 A O")).to eq [:paint_pixel, 1, 3, "A"]
    end
  end

  context 'V command' do
    it 'will interpret this to draw a vertical line' do
      expect(reader.interpret("V 2 3 6 W"))
        .to eq [:paint_vertical_line, 2, 3, 6, 'W']
    end

    it 'will ignore extra commands' do
      expect(reader.interpret("V 2 3 6 W O 4"))
        .to eq [:paint_vertical_line, 2, 3, 6, 'W']
    end
  end

  context 'H command' do
    it 'will interpret this to draw a horizontal line' do
      expect(reader.interpret("H 3 5 2 Z"))
        .to eq [:paint_horizontal_line, 3, 5, 2, 'Z']
    end

    it 'will ignore extra commands' do
      expect(reader.interpret("H 3 5 2 Z N M"))
        .to eq [:paint_horizontal_line, 3, 5, 2, 'Z']
    end
  end

  context 'S command' do
    it 'will interpret this to show the contents of the image' do
      expect(reader.interpret('S')).to eq [:display_image]
    end

    it 'will ignore extra commands' do
      expect(reader.interpret('S O H')).to eq [:display_image]
    end
  end

  context 'invalid arguments' do
    it 'will return invalid_command if an unknown command is put in' do
      expect(reader.interpret('E 1 4')).to eq [:invalid_command, 'E']
    end
  end
end
