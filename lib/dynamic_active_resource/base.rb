module DynamicActiveResource
  class Base < ActiveResource::Base
    def self.inherited(subclass)
      subclass.extend(DynamicActiveResource::CommonClassMethods)
    end
  end
end