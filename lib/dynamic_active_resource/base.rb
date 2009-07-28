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
  #   module DynamicClassSingletonMethods
  #     def count
  #       find(:all).size
  #     end
  #   end
  #
  #   module DynamicClassInstanceMethods
  #     def occupation
  #       return job if job
  #       'Unemployed' 
  #     end
  #   end
  # end
  #
  # The DynamicClassInstanceMethods will be available as instance methods in the objects created,
  # DynamicClassSingletonMethods will be available as class methods in the class of the object. Also
  # active resource associations are sometimes paginated. So even if you use find(:all), you get 
  # only the first few results. To overcome this, include in your DynamicClassSingletonMethods module
  # a method called find_without_pagination. In that method route it to acitve resource find with 
  # proper parameters. An example of the method implementation is 
  # 
  # def find_without_pagination(*args)
  #   scope = args.slice!(0)
  #   options = args.slice!(0) || {}
  #   options[:params] ||= {}
  #   options[:params].merge!({:page => 'all'})
  #   # call ActiveResource::Base::find with proper options
  #   find(scope, options)
  # end
  # 
  # The class level find method will automatically pick up this method if defined as a method in the
  # DynamicClassSingeletonMethod module else it will pass it to find. 
  #
  # ASSOCIATIONS
  # ------------
  #
  # This gem also provides active record like associations(highly experimental). Right now it provides only two
  # associations - 1) has_many, 2) belongs_to.
  #
  # 1) has_many 
  # -----------
  #
  # Taking the example from above the way it should be done
  #
  # class Person < DynamicActiveResource::Base
  #   has_many :cars
  #
  #   module DynamicClassSingletonMethods
  #     def count
  #       find(:all).size
  #     end
  #   end
  #
  #   module DynamicClassInstanceMethods
  #     def occupation
  #       return job if job
  #       'Unemployed' 
  #     end
  #     
  #     def resource_identifier
  #      name()
  #    end
  #   end
  # end
  # 
  # Next a car class has to be initialized
  # 
  # class Car < DynARBase (alias for DynamicActiveResource::Base, inbuilt in the gem)
  # end
  # 
  # set resource options only at the top level( Person in this case)
  #
  # Person.site = 'http://localhost:8080/'
  # Person.user = 'test'
  # Person.password = 'secret'
  #
  # associations take care of setting the site in the children classes automatically
  # you will notice that an additional method resource_identifier() has been defined
  # in the parent class. It would be discussed shortly.
  # 
  # The way associations work is if you do something like
  # 
  # person = Person.find('asur').cars it will hit the url http://localhost:8080/people/asur/cars.xml
  # 
  # You would notice that its getting the cars for the person with name 'asur'. It does so because
  # in the Person class a method called resource_identifier has been defined which says that the id
  # is actually name instead of the database id. If the id attribute in the xml is set appropriately
  # (to 'name' in this case) then you do not need to define the method.
  # 
  # 2) belongs_to
  # -------------
  # 
  # Again, referring to the example above
  # 
  # class Person < DynamicActiveResource::Base
  #   has_many :cars
  #
  #   module DynamicClassSingletonMethods
  #     def count
  #       find(:all).size
  #     end
  #   end
  #
  #   module DynamicClassInstanceMethods
  #     def occupation
  #       return job if job
  #       'Unemployed' 
  #     end
  #     
  #     def resource_identifier
  #      name()
  #    end
  #   end
  # end
  # 
  # Next a car class has to be initialized
  # 
  # class Car < DynARBase (alias for DynamicActiveResource::Base)
  #   belongs_to :person
  # end
  #
  # Right now belongs_to supports only assocation with a single class. After defining this you 
  # automatically have a method 'person' available.
  #
  # car = Car.find('WB1234I')
  # owner = car.person
  class Base < ActiveResource::Base
    def self.inherited(subclass)
      subclass.extend(DynamicActiveResource::CommonClassMethods)
      subclass.extend(DynamicActiveResource::Associations)
    end
  end
end

# shorter name
DynARBase = DynamicActiveResource::Base