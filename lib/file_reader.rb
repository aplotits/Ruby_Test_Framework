require_relative 'helpers'
require 'stringio'
require 'yaml'

class FileReader
include Helpers
  def initialize(file_path)
    raise RuntimeError, "empty string" if Helpers::is_string_empty?(file_path)
    @file_path = file_path
  end

  def open_file
    raise RuntimeError, "#{@file_path} is not a file" unless File.file?(@file_path)
    file_handle = IO.read(@file_path)
    return file_handle
  end

  def read_file(file_handle)
    raise RuntimeError, "null file handle" if file_handle.nil?
    @content = StringIO.open(file_handle)
    return @content.string
  end

  def read_yaml_file(file_handle)
    raise RuntimeError, "null file handle" if file_handle.nil?
    @content = StringIO.open(file_handle)
    yaml_content = YAML.load_stream(@content)
    return yaml_content
  end

  def get_file_content
    file_handle = open_file
    @content = read_file(file_handle)
    return @content
  end

end
