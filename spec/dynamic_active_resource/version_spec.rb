require File.dirname(__FILE__) + '/../spec_helper'

describe 'DynamicActiveResource::Version' do
  it "should return the proper version" do
    DynamicActiveResource::Version::to_s.should == '0.1.6'
  end
end