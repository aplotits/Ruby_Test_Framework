require_relative 'helpers'
require_relative 'file_reader'
require_relative 'bev_test'
require 'stringio'
require 'yaml'

class TestSuite
include Helpers
attr_accessor :suite_path, :suite_name, :test_type, :suite_configuration
CONFIGURATION = "suite_configuration.yaml"
SUCCESS_EXIT_CODE = 0
FAILURE_EXIT_CODE = 1
FAILURE_STATUS = 'FAIL'
SUCCESS_STATUS = 'PASS'

  def initialize(test_suite_path)
    raise RuntimeError, "empty string" if Helpers::is_string_empty?(test_suite_path)
    @suite_path = test_suite_path
    @suite_name = ''
    @test_type  = ''
    @tests = Array.new
    @files = Array.new
    @prerequisites = Array.new
  end

  def read_suite_configuration
    suite_configuration_path = Helpers.join_paths(@suite_path, CONFIGURATION)
    file_reader              = FileReader.new(suite_configuration_path)
    file_handle              = file_reader.open_file
    @suite_configuration     = file_reader.read_yaml_file(file_handle)
  end

  def suite_name
    @suite_name = @suite_configuration[0]["configurations"]["suite_name"]
  end

  def test_type
    @test_type = @suite_configuration[0]["configurations"]["test_type"]
  end

  def run_suite
    create_prerequisites
    run_prerequisites
    # create_tests
    # run_tests
  end

  def create_prerequisites
    @files = Helpers::get_all_files(@suite_path)
    if Helpers.all_files_exist?(@files)
      command_array = @files.select {|i| i =~ /Command_/}
      # Assume there is only one command per suite for now
      command = command_array[0]
      @prerequisites.push(command)
    end
  end

  def run_prerequisites
    @prerequisites.each do |p|
      directive = get_directive(p)
      exit_code = run_command(directive)
      check_exit_code(exit_code)
      puts exit_code
    end
  end

  def get_directive(file)
    file_reader = FileReader.new(file)
    file_handle = file_reader.open_file
    command = file_reader.get_file_content
    raise RuntimeError, "command is nil or empty string" if Helpers::is_string_empty?(command) ||
      Helpers::is_nil?(command)
    clean_command = command.chomp
    return clean_command
  end

  def run_command(command)
    executor = CommandExecutor.new(command)
    exit_code = executor.execute()
    return exit_code
  end

  def check_exit_code(code)
    status = code == SUCCESS_EXIT_CODE ?  SUCCESS_STATUS :  FAILURE_STATUS
    return status
  end

  # def create_tests

  #   # test = create_one_test
  #   # @tests.push(test)
  # end

  # def run_tests
  #   @tests.each do |test|
  #     test.run
  #   end
  # end

  # def create_one_test
  #   test_name = test_type + "Test"
  #   test = Object::const_get(test_name).new (@suite_path)
  #   return test
  # end

end
