require_relative 'base_test'
require_relative 'helpers'
require_relative 'file_reader'

class BevTest < BaseTest
  attr_accessor :test_hash, :directives, :name, :exit_code
  SUCCESS_EXIT_CODE = 0
  FAILURE_EXIT_CODE = 1
  FAILURE_STATUS = 'FAIL'
  SUCCESS_STATUS = 'PASS'

  def initialize(directory)
    super(directory)
    @test_hash = Hash.new
    @directives = Hash.new
    @name = ''
    @exit_code = FAILURE_EXIT_CODE
  end

  def filter_tests(files_array)
    test_array = files_array.select {|i| i =~ /^Test_\d+/}
    return test_array
  end

  def group_tests(tests_array)
    groups = Array.new
    index = 0
    tests_array.each do |entry|
      group = tests_array.select {|i| i =~ /Test_#{index}/}
      groups[index] = group
      index = index + 1
    end
    return groups
  end

  def test_hash(test_array)
    test = Hash.new
    command_array = test_array.select {|i| i =~ /Command_/}
    # Assume there is only one command per suite for now
    command = command_array[0]
    # Subtract one for command and divide by two - query AND expected
    number_tests = (test_array.length - 1) / 2
    # Iterate through number of tests
    h = Hash.new
    0.upto(number_tests - 1) do |i|
      query = test_array.select {|entry| entry =~ /Query_#{i}/}
      expected = test_array.select {|entry| entry =~ /Expected_#{i}/}
      h[query[0]] = expected[0]
      test[command] = h
    end
    @test_hash = test
  end

  def create
    files = Helpers::get_all_files(@directory)
    #Check all files exist and are files
    if Helpers.all_files_exist?(files)
      test_hash(files)
    end
    create_directives
  end


  def create_directives
    @test_hash.each do |key, entry|
      test = Hash.new
      command = get_directive(key)
      entry.each do |q, e|
        actual = e.sub('Expected', 'Actual')
        query = get_directive(q)
        query = Helpers::concatenate_strings(query, ' > ', actual)
        expected = Helpers::concatenate_strings('diff', ' ', e, ' ', actual)
        test[query] = expected
      end
      @directives[command] = test
    end
  end

  def execute
    @directives.each do |key, entry|
      @exit_code = run_command(key)
      check_exit_code(@exit_code)
      entry.each do |q, e|
        @exit_code = run_command(q)
        check_exit_code(@exit_code)
        @exit_code = run_command(e)
        test_status = check_exit_code(@exit_code)
        puts "TEST STATUS IS: #{test_status}"
      end
    end
  end

# TODO: Move to Helpers
  def check_exit_code(code)
    status = code == SUCCESS_EXIT_CODE ?  SUCCESS_STATUS :  FAILURE_STATUS
    return status
  end

  def run_command(command)
    executor = CommandExecutor.new(command)
    exit_code = executor.execute()
    return exit_code
  end

  def run
    create
    execute
  end

# TODO remove or put in Helpers Module
  # def get_directive(file)
  #   file_reader = FileReader.new(file)
  #   file_handle = file_reader.open_file
  #   command = file_reader.get_file_content
  #   raise RuntimeError, "command is nil or empty string" if Helpers::is_string_empty?(command) ||
  #     Helpers::is_nil?(command)
  #   clean_command = command.chomp
  #   return clean_command
  # end

end