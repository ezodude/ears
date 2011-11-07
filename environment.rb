# encoding: utf-8

require 'rubygems'
require 'bundler'

Bundler.require

Encoding.default_internal, Encoding.default_external = ['utf-8'] * 2