require_relative 'base_test'
require_relative 'helpers'
require_relative 'file_reader'

class GraspTest < BaseTest

  def initialize()
    super()
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

  def create_tests(test_groups)
   #  tests = Hash.new
   #  test_groups.each do |entry|
   #    one_test = Hash.new
   #    one_test = create_one_test(entry)
   #    tests.merge(one_test)
   #  end
   # puts "tests are #{tests}"
   #  return tests
  end

  def create_one_test(test_array)
    # test = Hash.new
    # h = Hash.new
    # puts "test_array #{test_array}"
    # command = test_array.select {|i| i =~ /Command_/}
    # index = 0
    # test_array.each do |entry|
    #   query = test_array.select {|entry| entry =~ /Query_#{index}/}
    #   expected = test_array.select {|entry| entry =~ /Expected_#{index}/}
    #   # skip if query or expected is nil
    #   next if query[0].nil? || expected[0].nil?
    #   h[query[0]] = expected[0]
    #   test[command[0]] = h
    #   index = index + 1
    # end
    # puts "test is #{test}"
    # return test
  end

end