require 'pathname'

module Helpers
  def Helpers.is_string_empty?(some_string)
    some_string.empty?
  end

  def Helpers.concatenate_strings(*args)
    return args.join
  end

  def Helpers.join_paths(string_one, string_two)
    path_one = Pathname.new(string_one)
    path_two = Pathname.new(string_two)
    new_path = path_one.join(path_two)
    return new_path.to_s
  end

  def Helpers.get_all_directories(path)
    raise RuntimeError, 'Path is not directory' if not is_path_directory?(path)
    directories = Array.new
    dir = Helpers.join_paths(path, '*')
    directories = Dir.glob(dir).select {|f| File.directory? f}
    return directories
  end

  def Helpers.get_all_files(path)
    raise RuntimeError, 'Path is not directory' if not is_path_directory?(path)
    files = Array.new
    Dir.foreach(path) do |f|
      absolute_path = join_paths(path, f)
      files.push(absolute_path) if is_path_file?(absolute_path)
    end
    return files
  end

  def Helpers.all_files_exist?(array)
    raise RuntimeError, "Array is empty or nil" if is_array_empty_nil?(array)
    array.each {|entry| raise RuntimeError, "Files does not exist" unless is_path_file?(entry)}
  end

  def Helpers.is_path_directory?(path)
    return Dir.exist?(path)
  end

  def Helpers.is_path_file?(path)
    return File.file?(path)
  end

  def Helpers.is_array_empty_nil?(array_to_test)
    return is_array_empty?(array_to_test) || is_nil?(array_to_test)
  end

  def Helpers.is_array_empty?(array_to_test)
    raise RuntimeError, "Array is nil" if is_nil?(array_to_test)
    return array_to_test.empty?
  end

  def Helpers.is_nil?(entity)
    return entity.nil?
  end

  def Helpers.get_filename_from_path(filepath)
    path = Pathname.new(filepath)
    return path.basename(path.extname)
  end

  def Helpers.run_command(command)
    executor = CommandExecutor.new(command)
    return executor.execute()
  end
end