require_relative 'file_reader'
require_relative 'command_executor'
require_relative 'controller'

class Invoker

  attr_accessor :test_configuration

  def self.run
    self.check_command_line_arguments(ARGV)
    controller = Controller.new (ARGV[0])
    controller.execute
  end

  def self.check_command_line_arguments(arguments)
    if arguments.length == 0
      abort "\nError: Test configuration file is required. Aborting...\n\n"
    elsif arguments.length > 1
      abort "\nError: The program takes one argument maximum. Aborting...\n\n"
    end
  end

  self.run

end