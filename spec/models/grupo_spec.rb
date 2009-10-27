require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Grupo do

  it {should have_and_belong_to_many(:archivos)}

  it {should validate_presence_of(:nombre) }
  it {should have_and_belong_to_many(:usuarios) }
  it {should have_many(:proyectos) }

  describe "Valido" do
  
    before(:each) do
      @nombre = " Es el nuevo"
      @grupo = Grupo.new(:nombre => @nombre.dup, :descripcion => "Solo texto")
      @grupo.save
    end

    it "debe limpiar espacios" do
      @grupo.nombre.should == @nombre.squish
    end

    it "debe tener to_s() nombre" do
      @grupo.to_s.should == @grupo.nombre
    end

  end

  describe "Invalido" do
  
    before(:each) do
      @nombre = " Es el nuevo 1"
      @grupo = Grupo.new(:nombre => @nombre.dup, :descripcion => "Solo texto")
      @grupo.save
    end

    it "debe dar invalido" do
      @grupo.valid?.should == false
    end

    it "error de formato nombre" do
      @grupo.errors[:nombre].should == I18n.t('activerecord.errors.messages.invalid')
    end

    it "no debe borrar espacios si no es valido" do
      @grupo.nombre.should_not == @nombre.squish
    end

  end

end
