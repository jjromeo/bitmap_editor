class InstructionReader
  COMMANDS = {
    "I" => :create_image,
    "C" => :clear,
    "L" => :paint_pixel,
    "V" => :paint_vertical_line,
    "H" => :paint_horizontal_line,
    'S' => :display_image
  }

  def interpret(string)
    args = string.split(" ")
    command_letter = args.slice!(0)
    interpret_command(command_letter, args)
  end

  def interpret_command(command_letter, args)
    command = COMMANDS[command_letter] || :invalid_command
    arguments = sanitize_arguments(args)
    [command, *arguments]
  end

  def sanitize_arguments(args)
    args.map do |arg|
      arg.to_i == 0 ? arg.to_s : arg.to_i
    end
  end
end
