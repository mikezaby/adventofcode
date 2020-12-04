#!/usr/bin/env ruby

require 'active_support/all'
require './file_helper'

def advent(*current_advent)
  @output = nil

  if current_advent.any?
    @year, @day, @part = current_advent
  end

  base_path = "20#{@year}/#{@day}"
  data_path = [base_path, "data.txt"].join("/")
  code_path = [base_path, "part#{@part}.rb"].join("/")

  @data = File.exist?(data_path) ? FileHelper.new(data_path) : nil

  load code_path

  @output
end

def reload!
  advent
end
