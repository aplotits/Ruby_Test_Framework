# TODO: unit test for execute method
class CommandExecutor
include Helpers
  attr_reader :command, :std_output, :exit_code

  def initialize(command)
    raise RuntimeError, "empty string" if Helpers::is_string_empty?(command)
    @command = command
    @std_output = ''
    @std_error = ''
    @exit_code = ''
  end

  def execute
    puts "EXECUTING THIS COMMAND: #{command}"
    output = %x{ #{@command}}
    @std_output = output.chomp()
    @exit_code = $?.to_i
    return @exit_code
  end

end