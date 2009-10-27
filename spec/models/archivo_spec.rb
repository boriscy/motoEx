require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Archivo do

  it{should belong_to(:proyecto)}
  it{should have_and_belong_to_many(:grupos)}
  it{should have_and_belong_to_many(:usuarios)}

  before(:each) do
    @valid_attributes = {
      :proyecto_id => 1,
      :nombre => "value for nombre",
      :tipo => "value for tipo",
      :usuarios => "value for usuarios",
      :grupos => "value for grupos",
      :publico => false
    }
    @archivo = Archivo.create(@valid_attributes)
  end

  it "Archivo valido" do
    Archivo.create!(@valid_attributes)
  end

  it "debe retornar to_s() nombre" do
    @archivo.to_s.should == @archivo.nombre
  end

  it "debe tener como estado inicial 'borrador'" do
    @archivo.estado.should == Archivo.aasm_initial_state.to_s
  end


end
