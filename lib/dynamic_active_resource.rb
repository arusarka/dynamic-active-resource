begin
  require 'active_resource'
rescue LoadError
  require 'rubygems'
  require 'active_resource'
end

$:.unshift File.expand_path(File.dirname(__FILE__))

require 'dynamic_active_resource/common_class_methods'
require 'dynamic_active_resource/helpers'
require 'dynamic_active_resource/version'
require 'dynamic_active_resource/base'

module DynamicActiveResource
end