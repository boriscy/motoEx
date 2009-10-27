require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Version do

  before(:each) do
    @valid_attributes = {
      :archivo_id => 1,
      :file => '/home/boris/test.jpg',
      :ultima => false
    }
  end

  it {should belong_to(:archivo)}

  it "should create a new instance given valid attributes" do
    @ver = Version.create!(@valid_attributes)
  end
end
