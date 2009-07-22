require "../../lib/dynamic_active_resource"

class Card < DynamicActiveResource::Base
  module ClassMethods
    def find_without_pagination(*args)
      scope = args.slice!(0)
      options = args.slice!(0) || {}
      options[:params] ||= {}
      options[:params].merge!({:page => 'all'})

      # call ActiveResource::Base::find with proper options
      find(scope, options)
    end
  end
end

Card.site = 'http://localhost:9090/projects/api_test'
Card.user = 'testuser'
Card.password = 'testuser'

puts Card.find_without_pagination(:all).size