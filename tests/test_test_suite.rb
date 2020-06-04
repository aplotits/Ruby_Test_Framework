require "./lib/helpers"
require "./lib/test_suite"

RSpec.describe TestSuite do

# Tests for Helpers Module
  describe 'check TestSuite methods' do
    it 'checks for initialization with empty string' do
      expect {test_suite = TestSuite.new("")}.to raise_exception
    end

    it 'checks for initializion test suit path' do
      test_suite = TestSuite.new("some/path")
      expect(test_suite.suite_path).to eq("some/path")
    end

    it 'checks for reading configuration' do
      test_suite = TestSuite.new("some path")
      yaml_text = <<-EOF
        configurations:
          suite_name: bev
          test_type: grasp
      EOF
      file_reader = FileReader.new ("some path")
      test_suite.suite_configuration = file_reader.read_yaml_file(yaml_text)
      expect(test_suite.suite_name).to eq("bev")
      expect(test_suite.test_type).to eq("grasp")
    end

    it 'checks for test creation' do
      test_suite = TestSuite.new("some path")
      yaml_text = <<-EOF
        configurations:
          suite_name: BEV
          test_type: Bev
      EOF
      file_reader = FileReader.new ("some path")
      test_suite.suite_configuration = file_reader.read_yaml_file(yaml_text)
      tests = test_suite.create_tests
      expect(tests.length).to eq(1)
      expect(tests[0]).to be_instance_of(BevTest)
    end
  end

end
