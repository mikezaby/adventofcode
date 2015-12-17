class FileHelper
  include Enumerable

  attr_reader :path, :file

  def initialize(path)
    @path = path
    @file = File.new(path, 'r')
  end

  def each(&block)
    file.each_line(&block)
  end
end
