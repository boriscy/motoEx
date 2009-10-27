require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Proyecto, "Valido" do


  before(:each) do
    @valid_attributes = {
      :grupo_id => 1,
      :nombre => "Primer  proyecto"
    }
    @proyecto = Proyecto.create(@valid_attributes)
    s=0
  end

  it {should belong_to(:grupo)}
  it {should have_many(:archivos)}


  it {should validate_presence_of(:nombre)}
  it {should validate_presence_of(:grupo_id)}
  it {should validate_format_of(:nombre).with('2@{jhsd')}

  it "crear una instancia" do
    @proyecto.valid?.should == true
  end

  it "presenta nombre como to_s()" do
    @proyecto.to_s.should == @proyecto.nombre
  end

  it "debe borrar espacios" do
    @proyecto.nombre.should == @proyecto.nombre.squish
  end

end
