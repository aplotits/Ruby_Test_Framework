require_relative 'helpers'
require_relative 'file_reader'

class BaseTest
  attr_accessor :test_name, :test_status,

  STATUS_FAIL   = 'fail'
  STATUS_PASS   = 'pass'
  STATUS_NOTRUN = 'not_run'

  def initialize(directory)
    @path = ''
    @test_name = ''
    @test_status = STATUS_NOTRUN
    @directory = directory
  end
end