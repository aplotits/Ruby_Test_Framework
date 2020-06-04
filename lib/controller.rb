require_relative 'file_reader'
require_relative 'command_executor'
require_relative 'test_suite'

class Controller
include Helpers
  attr_accessor :test_configuration, :tests_directory_path, :test_suites

  def initialize(path)
    @test_configuration_path = path
    @tests_directory_path = ''
    @test_suites = Array.new
  end

  def read_test_configuration
    file_reader = FileReader.new(@test_configuration_path)
    file_handle = file_reader.open_file
    @test_configuration = file_reader.read_yaml_file(file_handle)
  end

  def set_test_directory_path
    @tests_directory_path = @test_configuration[0]["configurations"]["tests_location"]
  end

  def create_test_suites
    test_directories = Helpers.get_all_directories(@tests_directory_path)
    test_directories.each do |dir|
      test_suite = TestSuite.new(dir)
      test_suite.read_suite_configuration
      @test_suites.push(test_suite)
    end
  end

  def run_test_suites
    @test_suites.each do |suite|
      suite.run_suite
    end
  end

  def execute
    read_test_configuration
    set_test_directory_path
    create_test_suites
    run_test_suites
  end

end