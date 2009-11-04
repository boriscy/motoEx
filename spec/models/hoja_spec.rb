require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Hoja do
  before(:each) do
    @valid_attributes = {
      :archivo_id => 1,
      :numero => 0
    }
    @archivo = "ejemplos/example.xls"

    @path = mock("path", :path => @archivo)
    @archivo_mock = mock_model(Archivo, :archivo_excel_file_name => File.basename(@archivo), :archivo_excel => @path)
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
    @hoja.nombre.should == "Sheet1"
  end

  it "debe generar un archivo HTML" do
    @valid_attributes[:numero_hoja] = 2
    @hoja = Hoja.create(@valid_attributes)
    File.exists?(@hoja.ruta)
    @hoja.nombre.should == "Tres"
  end

  it "debe generar un archivo HTML y hoja 0" do
    @hoja = Hoja.create(@valid_attributes)
    @hoja.numero.should == 0
    File.exists?(@hoja.ruta)
  end

  it "debe asignar correctamente los ids al HTML" do
    @hoja = Hoja.create(@valid_attributes)
    html = File.open(@hoja.ruta){|f| Hpricot f}
    html.search("tr:eq(0) td:eq(0)").attr("id").should == "0_0"
    html.search("tr:eq(22) td:eq(0)").attr("id").should == "22_0"
    html.search("tr:eq(22) td:eq(1)").attr("id").should == "22_3"
    html.search("tr:eq(23) td:eq(0)").attr("id").should == "23_0"
    html.search("tr:eq(26) td:eq(0)").attr("id").should == "26_0"
    html.search("tr:eq(24) td:eq(0)").attr("id").should == "24_1"
    html.search("tr:eq(25) td:eq(0)").attr("id").should == "25_3"
  end

end
