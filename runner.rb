#!/usr/bin/env ruby

require 'pry'
require 'active_support/all'
require 'matrix'
require './file_helper'

@_init_constants = Object.constants.dup

def run(part = 1, date = Date.today)
  @output = nil

  (Object.constants - @_init_constants).each do |const|
    Object.send(:remove_const, const)
  end

  base_path = [date.year, date.day.to_s.rjust(2, "0")].join("/")
  data_path = [base_path, "data.txt"].join("/")
  demo_path = [base_path, "demo.txt"].join("/")
  code_path = [base_path, "part#{part}.rb"].join("/")

  @data = File.exist?(data_path) ? FileHelper.new(data_path).map(&:strip) : nil
  @demo = File.exist?(demo_path) ? FileHelper.new(demo_path).map(&:strip) : nil

  load code_path

  @output
end
