module DynamicActiveResource
  # ActiveResource makes connecting to rest resources very easy. However it has one problem 
  # and a big one at that. If you try setting the authentication credentials or the site or
  # collection name, element name for the class for the second time it doesn't work. E.g.
  #
  # class Person < ActiveResource::Base
  #   self.site = 'http://localhost:9090/'
  # end
  #
  # After sometime you change it to 
  #
  # Person.site = 'https://org-server/my_proj/'
  # Person.user = 'admin'
  # Person.password = 'secret'
  #
  # Then you do
  #
  # Person.find(:all) => It bombs
  #
  # This class provides a mechanism by which you can get rid of this problem. Extend DynamicActiveResource::Base
  # class in the actual class itself. Do not extend the extended class from ActiveResource::Base.
  # 
  # E.g.
  #
  # class Person < DynamicActiveResource::Base
  # end
  #
  # set the credentials
  #
  # Person.site = 'http://localhost:8080'
  # Person.user = 'foo'
  # Person.password = 'bar'
  # 
  # Thats it. Now create some objects
  #
  # asur = Person.new(:name => 'Asur', :job => 'fooling around', :status => 'Single and ready 2 mingle')
  # asur.save
  # 
  # Now change the class attributes
  #
  # Person.site = 'https://org-server/mingle'
  # Person.collection_name = 'boring_people'
  # 
  # Now instantiate an object
  #
  # rakhshas = Person.new(:name => 'Rakhshas', :job => 'eating people', :status => 'just woke up and hungry')
  # rakhshas.save => Voila !!!!!!! it works
  # 
  # CUSTOMIZATIONS
  # --------------
  # 
  # No amount of wrapping can provide very detailed customizations. Either you have a lot of methods
  # that are not being used or there is hardly anything at all. To oversome this problem this module
  # was written to provide only those methods which are common to most active resource objects.
  # However if you want to have a little more control over your active resource objects its very easy.
  # Here's how you would do it normally
  # 
  # class Person < ActiveResource::Base
  #   def self.count
  #     find(:all).size
  #   end
  #
  #   def occupation
  #     return job if job
  #     'Unemployed' 
  #   end
  # end
  #
  # To do the same thing, here's how you do it using this library
  #
  # class Person < DynamicActiveResource::Base
  #   module ClassMethods
  #     def count
  #       find(:all).size
  #     end
  #   end
  #
  #   module InstanceMethods
  #     def occupation
  #       return job if job
  #       'Unemployed' 
  #     end
  #   end
  # end
  #
  # The instance methods will be available as instance methods in the objects created, class methods
  # will be available as class methods in the class of the object.
  class Base < ActiveResource::Base
    def self.inherited(subclass)
      subclass.extend(DynamicActiveResource::CommonClassMethods)
    end
  end
end

# shorter name
DynARBase = DynamicActiveResource::Base