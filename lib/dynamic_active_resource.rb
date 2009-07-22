begin
  require 'active_resource'
rescue LoadError
  require 'rubygems'
  require 'active_resource'
end

$:.unshift File.expand_path(File.dirname(__FILE__))

require 'dynamic_active_resource/common_class_methods'
require 'dynamic_active_resource/helpers'

module DynamicActiveResource
  class Base < ActiveResource::Base
    def self.inherited(subclass)
      subclass.extend(DynamicActiveResource::CommonClassMethods)
    end
  end
end
