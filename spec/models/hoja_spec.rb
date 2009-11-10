require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Hoja do
  before(:each) do
    @valid_attributes = {
      :archivo_id => 1,
      :numero => 0
    }
    @archivo = "ejemplos/example.xls"
    Archivo.any_instance.stubs(:valid?).returns(true)
    Archivo.any_instance.stubs(:update_attribute).with(:lista_hojas, kind_of(Array))

    @path = mock("path", :path => @archivo)
    @archivo_mock = mock_model(Archivo, :archivo_excel_file_name => File.basename(@archivo), :prelectura => false, :archivo_excel => @path)
    @archivo_mock.stub!(:lista_hojas).and_return(mock("lista_hojas", :nil? => true))
    @archivo_mock.stub!(:valid?).and_return(true)
    @archivo_mock.stub!(:lista_hojas=)
    @archivo_mock.stub!(:save).and_return(true)
    Hoja.any_instance.stubs(:archivo).returns(@archivo_mock)

    @usuario_mock = mock_model(Usuario, :id => 1, :nombre => 'Juan', :valid? => true)
    Usuario.stub!(:find).with(kind_of(Fixnum)).and_return(@usuario_mock)
    @us = mock("record", :record => @usuario_mock)
    UsuarioSession.stub!(:find).and_return(@us)

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
    @valid_attributes[:numero] = 2
    @hoja = Hoja.create(@valid_attributes)
    File.exists?(@hoja.ruta)
    @hoja.nombre.should == "Tres"
    @hoja.numero.should == 2
  end

  it "debe generar un archivo HTML y hoja 0" do
    @hoja = Hoja.create(@valid_attributes)
    @hoja.numero.should == 0
    File.exists?(@hoja.ruta)
  end

  it "debe asignar correctamente los ids al HTML" do
    @hoja = Hoja.create(@valid_attributes)
    html = File.open(@hoja.ruta){|f| Hpricot f}
    html.search("tr:eq(0) td:eq(0)").attr("id").should == "1_1"
    html.search("tr:eq(22) td:eq(0)").attr("id").should == "23_1"
    html.search("tr:eq(22) td:eq(1)").attr("id").should == "23_4"
    html.search("tr:eq(23) td:eq(0)").attr("id").should == "24_1"
    html.search("tr:eq(26) td:eq(0)").attr("id").should == "27_1"
    html.search("tr:eq(24) td:eq(0)").attr("id").should == "25_2"
    html.search("tr:eq(24) td:eq(1)").attr("id").should == "25_4"
  end

  it "debe ejecutar prelectura en caso de que este seleccionado" do
    @archivo_mock.stub!(:prelectura).and_return(true)
    @valid_attributes[:numero] = 1
    @hoja = Hoja.create(@valid_attributes)

    html = File.open(@hoja.ruta){|f| Hpricot f}
    excel = Excel.new(File.join(RAILS_ROOT, "ejemplos", "example.xls"))
    excel.default_sheet = @hoja.numero + 1
    html.search("tr:eq(6) td:eq(1)").inner_text.should == excel.cell(7, "B").to_s
    html.search("tr:eq(18) td:eq(1)").inner_text.should == excel.cell(19, "B").to_s
    html.search("tr:eq(36) td:eq(5)").inner_text.should == excel.cell(37, "F").to_s

  end


end
