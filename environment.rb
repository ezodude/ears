# encoding: utf-8

require 'rubygems'
require 'bundler'

Bundler.require

Encoding.default_internal, Encoding.default_external = ['utf-8'] * 2

if ENV['FFMBC']
  FFMBC = ENV['FFMBC']
else
  FFMBC = '/usr/local/bin/ffmbc'
end

require 'cgi'