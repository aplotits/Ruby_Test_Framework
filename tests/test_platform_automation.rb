require "./lib/platform_automation.rb"
require "./lib/file_reader.rb"
require "./lib/command_executor.rb"
require "./lib/controller.rb"
# require "./lib/invoker"

# TODO Supress STDOUT for test/tests

RSpec.describe FileReader do
# Tests for FileReader Class
  describe 'check initialize' do
    it 'checks for empty argument' do
      expect {file_reader = FileReader.new ("")}.to raise_exception
    end
  end

  describe 'check reading file' do
    file_reader = FileReader.new ("some_path")
    it 'checks for null argument' do
      expect {file_reader.read_file(nil)}.to raise_exception
    end

    it 'checks for reading iostring' do
      content = file_reader.read_file("some string")
      expect(content).to eq("some string")
    end

    it 'checks yaml file reader' do
      yaml_text = <<-EOF
        A_NAME: ABC
        A_ALIAS: my_alias
      EOF
      yaml_content = file_reader.read_yaml_file(yaml_text)
      expect(yaml_content[0]["A_NAME"]).to eq("ABC")
      expect(yaml_content[0]["A_ALIAS"]).to eq("my_alias")
    end
    it 'checks for null argument' do
      expect {file_reader.read_yaml_file(nil)}.to raise_exception
    end

  end

  # Tests for ClassExecutor Class
  describe 'check initialize' do
    it 'checks for empty argument' do
      expect {file_reader = CommandExecutor.new ("")}.to raise_exception
    end
  end

  describe 'execute command' do
    it 'checks for valid command' do
      command_executor = CommandExecutor.new ("echo SPLENDID")
      command_executor.execute
      expect(command_executor.exit_code).to eq(0)
      expect(command_executor.std_output).to eq("SPLENDID")
    end
    it 'checks for invalid command' do
      command_executor = CommandExecutor.new ("cat blah")
      command_executor.execute
      expect(command_executor.exit_code).not_to eq(0)
    end
  end

# Disable the test because require on top invokes self.run
  describe 'invoker' do
    xit 'check for command line arguments' do
      expect {Invoker.check_command_line_arguments(Array.new)}.to raise_error(SystemExit)
    end
  end


  describe 'controller' do
    controller = Controller.new ("some path")
    it 'check for path to tests directory' do
      yaml_text = <<-EOF
        configurations:
          tests_location: /Users/alexpoltitsa/Insights/QAandTesting/Automation/tests
      EOF
      file_reader = FileReader.new ("some path")
      controller.test_configuration = file_reader.read_yaml_file(yaml_text)
      controller.set_test_directory_path
      expect(controller.tests_directory_path).to eq("/Users/alexpoltitsa/Insights/QAandTesting/Automation/tests")
    end

  end

end
