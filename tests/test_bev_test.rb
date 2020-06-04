require './lib/bev_test'

RSpec.describe BevTest do

# Tests for Test Class
  describe 'check BevTest methods' do

    # it 'checks for initialization with empty string' do
    #   expect {test_suite = TestSuite.new("")}.to raise_exception
    # end

    it 'check for filter array for Test string' do
      files    = Array['Test_0_Command_0.txt', 'Test_0_Query_0.txt', 'someTest', 
                 'Test_0_Expected_0.txt', 'someTestagain', 'Test_0_Expected_1.txt', 'Test_0_Query_1.txt']
      expected = Array['Test_0_Command_0.txt', 'Test_0_Query_0.txt', 'Test_0_Expected_0.txt',
                 'Test_0_Expected_1.txt', 'Test_0_Query_1.txt']
      bev    = BevTest.new ('some/path')
      expect(bev.filter_tests(files)).to match_array(expected)
    end

    it 'checks for grouped tests' do
      tests       = Array['Test_0_Command_1.txt', 'Test_0_Query_0.txt', 'Test_0_Expected_1.txt', 'Test_1_Expected_1.txt']
      expected    = Array.new
      expected[0] = ['Test_0_Command_1.txt', 'Test_0_Query_0.txt', 'Test_0_Expected_1.txt']
      expected[1] = ['Test_1_Expected_1.txt']
      grasp = BevTest.new('some/path')
      grouped_tests = grasp.group_tests(tests)
      expect(grouped_tests[0]).to match_array(expected[0])
      expect(grouped_tests[1]).to match_array(expected[1])
    end

    it 'checks for  test hash creation' do
      test_array       = Array['Test_0_Command_0.txt', 'Test_0_Query_0.txt', 'Test_0_Expected_0.txt',
                    'Test_0_Query_1.txt', 'Test_0_Expected_1.txt']
      bev = BevTest.new ('some/path')
      actual = bev.test_hash(test_array)
      expected    = Hash.new
      query = Hash.new
      query['Test_0_Query_0.txt'] = 'Test_0_Expected_0.txt'
      query['Test_0_Query_1.txt'] = 'Test_0_Expected_1.txt'
      expected['Test_0_Command_0.txt'] = query
      expect(actual).to eq(expected)
    end

    it 'checks exit code' do
      bev = BevTest.new('some/path')
      exit_code = bev.check_exit_code(0)
      expect(exit_code).to eq('PASS')
    end

    it 'checks exit code' do
      bev = BevTest.new('some/path')
      exit_code = bev.check_exit_code(255)
      expect(exit_code).to eq('FAIL')
    end

  end

end