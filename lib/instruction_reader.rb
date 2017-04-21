class InstructionReader
  COMMANDS = {
    "I" => [:create_image, 2],
    "C" => [:clear, 0],
    "L" => [:paint_pixel, 3],
    "V" => [:paint_vertical_line, 4],
    "H" => [:paint_horizontal_line, 4],
    'S' => [:display_image, 0]
  }

  def interpret(string)
    args = string.split(" ")
    command_letter = args.slice!(0)
    interpret_command(command_letter, args)
  end

  private

  def interpret_command(command_letter, args)
    command, expected_arity = COMMANDS[command_letter] || :invalid_command
    arguments = sanitize_arguments(args, expected_arity)
    [command, *arguments]
  end

  def sanitize_arguments(args, expected_arity)
    all_args = args.map do |arg|
      arg.to_i == 0 ? arg.to_s : arg.to_i
    end
    expected_arity.zero? ? [] : all_args.slice(0..(expected_arity - 1))
  end
end
