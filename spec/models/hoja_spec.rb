require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Hoja do
  before(:each) do
    @valid_attributes = {
      :archivo_id => 1,
      :nombre => "value for nombre",
      :numero => 1
    }
    @path = mock("path", :path => "ejemplos/VentasPrecio2000-2008.xls")
    @archivo_mock = mock_model(Archivo, :archivo_excel_file_name => "VentasPrecio2000-2008.xls", :archivo_excel => @path)
    Hoja.any_instance.stubs(:archivo).returns(@archivo_mock)
  end

  it "should create a new instance given valid attributes" do
    Hoja.create!(@valid_attributes)
  end

  it "debe retornar la ruta del archivo" do
    @hoja = Hoja.create(@valid_attributes)
    @hoja.ruta.should == File.join(RAILS_ROOT, "ejemplos/#{@hoja.numero}.html")
  end

  it "debe asignar nombre" do
    @hoja = Hoja.create(@valid_attributes)
    @hoja.nombre.should == "2000"
  end

  it "debe generar un archivo HTML" do
    @valid_attributes[:numero_hoja] = 3
    @hoja = Hoja.create(@valid_attributes)
    File.exists?(@hoja.ruta)
  end

  it "debe generar un archivo HTML y hoja 0" do
    @hoja = Hoja.create(@valid_attributes)
    @hoja.numero.should == 0
    File.exists?(@hoja.ruta)
  end

  it "debe asignar correctamente los ids al HTML" do

  end
end
