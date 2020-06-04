require "./lib/helpers.rb"

# require "./lib/invoker"

# TODO Supress STDOUT for test/tests

RSpec.describe Helpers do

# Tests for Helpers Module
  describe 'check Helpers methods' do
    include Helpers

    it 'checks for empty string' do
      expect(Helpers::is_string_empty?("")).to be(true)
    end

    it 'checks for empty string' do
      expect(Helpers::is_string_empty?("nonempty")).to be(false)
    end

    it 'check for path concatenation' do
      expect(Helpers::join_paths('Hello','World')).to eq("Hello/World")
    end
  end

    it 'check for empty array' do
      expect(Helpers::is_array_empty?(Array.new)).to be (true)
    end

    it 'check for non empty array' do
      array = Array[1,2,3,4]
      expect(Helpers::is_array_empty?(array)).to be(false)
    end

    it 'check and raise for nil array' do
      expect {Helpers::is_array_empty?(nil)}.to raise_exception
    end

    it 'check for nil array false' do
      array = Array.new
      expect(Helpers::is_nil?(Array.new)).to be(false)
    end

    it 'check for nil array' do
      expect(Helpers::is_array_empty_nil?(Array.new)).to be(true)
    end

    it 'check for nil entity' do
      expect(Helpers::is_nil?(String.new)).to be(false)
    end

    it 'check for non nil entity' do
      expect(Helpers::is_nil?(nil)).to be(true)
    end

    it 'check for non empty array' do
      array = Array[1,2,3,4]
      expect(Helpers::is_array_empty_nil?(array)).to be(false)
    end

    it 'check and raise for nil array' do
      expect {Helpers::is_array_empty_nil?(nil)}.to raise_exception
    end

    it 'check for directory existence' do
      expect(Helpers::is_path_directory?("/tmp")).to be(true)
    end

    it 'check for directory non existence' do
      expect(Helpers::is_path_directory?("/blah")).to be(false)
    end

    it 'check for if file is directory' do
      expect(Helpers::is_path_file?("/tmp")).to be(false)
    end

    it 'check for directory non existence' do
      expect(Helpers::is_path_file?("/blah")).to be(false)
    end

    it 'checks for file existence' do
      expect(Helpers::is_path_file?(__FILE__)).to be(true)
    end

    it 'check and raise if directory does not exist' do
      expect {Helpers::get_all_directories("/blah")}.to raise_error('Path is not directory')
    end

    it 'check and raise if directory does not exist' do
      expect {Helpers::get_all_files("/blah")}.to raise_error('Path is not directory')
    end

    it 'check and raise if file in array does not exist' do
      array = ['not/there']
      expect {Helpers::all_files_exist?(array)}.to raise_exception
    end

    it 'check for filename from path' do
      expect(Helpers::get_filename_from_path('/start/next/filename'))
    end

    it 'checs for string concatenation' do
      expect(Helpers::concatenate_strings('one_', 'two', ' < ', 'three')).to eq('one_two < three')
    end

end
