require './lib/grasp_test'

RSpec.describe GraspTest do

# Tests for Test Class
  xdescribe 'check GrapsTest methods' do

    # it 'checks for initialization with empty string' do
    #   expect {test_suite = TestSuite.new("")}.to raise_exception
    # end

    it 'check for filter array for Test string' do
      files    = Array['Test_1_Command_1.txt', 'Test_1_Query_1.txt', 'someTest', 'Test_1_Expected_1.txt', 'someTestagain', 'Test_2_Expected_1.txt']
      expected = Array['Test_1_Command_1.txt', 'Test_1_Query_1.txt', 'Test_1_Expected_1.txt', 'Test_2_Expected_1.txt']
      grasp    = GraspTest.new
      expect(grasp.filter_tests(files)).to match_array(expected)
    end

    it 'checks for grouped tests' do
      tests       = Array['Test_0_Command_1.txt', 'Test_0_Query_0.txt', 'Test_0_Expected_1.txt', 'Test_1_Expected_1.txt']
      expected    = Array.new
      expected[0] = ['Test_0_Command_1.txt', 'Test_0_Query_0.txt', 'Test_0_Expected_1.txt']
      expected[1] = ['Test_1_Expected_1.txt']
      grasp = GraspTest.new
      grouped_tests = grasp.group_tests(tests)
      expect(grouped_tests[0]).to match_array(expected[0])
      expect(grouped_tests[1]).to match_array(expected[1])
    end

    it 'checks for one test creation' do
      test_array = Array.new
      test_array = ['Test_0_Command_0.txt', 'Test_0_Query_0.txt', 'Test_0_Query_1.txt','Test_0_Expected_0.txt', 'Test_0_Expected_1.txt']
      expected = Hash.new
      query = Hash.new
      query['Test_0_Query_0.txt'] = 'Test_0_Expected_0.txt'
      query['Test_0_Query_1.txt'] = 'Test_0_Expected_1.txt'
      expected['Test_0_Command_0.txt'] = query
      grasp = GraspTest.new
      actual = grasp.create_one_test(test_array)
      expect(actual).to eq(expected)
    end

    it 'checks for multiple test creation' do
      tests       = Array['Test_0_Command_0.txt', 'Test_0_Query_0.txt', 'Test_0_Expected_1.txt', 'Test_1_Command_1.txt', 'Test_1_Query_0.txt', 'Test_1_Expected_1.txt',]
      test_groups = Array.new
      grasp = GraspTest.new
      test_groups = grasp.group_tests(tests)
      puts test_groups
      actual = grasp.create_tests(test_groups)
      expected    = Hash.new
      puts actual
      expect(actual).to eq(expected)
    end

  end

end