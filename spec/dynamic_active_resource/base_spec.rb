require File.dirname(__FILE__) + '/../spec_helper'

describe 'DynamicActiveResource::Base' do
  it "should extend the subclass properly" do    
    DynamicActiveResource::CommonClassMethods.should_receive(:extended)
    DynamicActiveResource::Associations.should_receive(:extended)
    class Child < DynamicActiveResource::Base
    end
  end
end