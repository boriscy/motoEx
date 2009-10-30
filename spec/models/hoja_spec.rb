require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Hoja do
  before(:each) do
    @valid_attributes = {
      :archivo_id => 1,
      :nombre => "value for nombre",
      :numero => 1
    }
  end

  it "should create a new instance given valid attributes" do
    Hoja.create!(@valid_attributes)
  end
end
