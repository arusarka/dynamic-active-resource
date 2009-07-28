require File.dirname(__FILE__) + '/../spec_helper'

class DummyAssociationClass
  extend DynamicActiveResource::Associations
end

describe 'DynamicActiveResource::AssociationClass' do
  after(:each) do
    DummyAssociationClass.instance_variable_set(:@associations, nil)
  end
  
  it "should set a has_many association properly" do
    class DummyAssociationClass
      has_many :dummies
    end
    associations = DummyAssociationClass.instance_variable_get(:@associations)
    associations.first.should be_instance_of(DynamicActiveResource::Associations::HasMany)
  end
  
  it "should set a belongs_to association properly" do
    class DummyAssociationClass
      belongs_to :test
    end
    associations = DummyAssociationClass.instance_variable_get(:@associations)
    associations.first.should be_instance_of(DynamicActiveResource::Associations::BelongsTo)
  end
end