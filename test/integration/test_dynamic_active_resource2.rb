require File.dirname(__FILE__) + '/../../lib/dynamic_active_resource'

class Card < DynARBase
  belongs_to :project
  module DynamicClassSingletonMethods
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

class Project < DynARBase
  has_many :cards
  module DynamicClassInstanceMethods
    def resource_identifier
      identifier()
    end
  end
end

Project.site = 'http://localhost:9090/'
Project.user = 'testuser'
Project.password = 'testuser'
proj = Project.find('api_test')

puts proj.resource_identifier

# association = proj.class.instance_variable_get(:@children_associations).detect { |association| association[:method] }
# card_class = eval(association[:class])
# puts proj.send(:child_association_method?, 'cards')

cards = proj.cards
# puts cards.send(:create_resource_class).collection_path
puts cards.size
# puts cards[0].class.instance_variable_get(:@associations)
proj1 = cards[0].project
puts proj1.identifier
# 
puts proj1.cards.size