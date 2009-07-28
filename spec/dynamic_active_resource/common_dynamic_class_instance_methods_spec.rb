require File.dirname(__FILE__) + '/../spec_helper'

class Resource
  include DynamicActiveResource::CommonDynamicClassInstanceMethods
end

describe 'DynamicActiveResource::CommonDynamicClassInstanceMethods' do
  it "should find the resource identifier properly" do
    resource = Resource.new
    resource.should_receive(:id).and_return(1)
    resource.resource_identifier.should == 1
  end
  
  it "should be able to detect a association method properly" do
    resource = Resource.new
    association = DynamicActiveResource::Associations::Base.new :person
    Resource.instance_variable_set(:@associations, [association])
    resource.send(:association_method?, 'person').should == true
    Resource.instance_variable_set(:@associations, nil)
  end
end